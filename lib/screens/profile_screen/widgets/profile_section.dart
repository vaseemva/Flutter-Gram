import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/followers_page/followers_page.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/count_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/title_text.dart';
import 'package:flutter_gram/screens/settings_page/settings_page.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class ProfileSection extends StatelessWidget {
  ProfileSection({
    super.key,
    required this.screensize,
    required this.snap,
  });

  final Size screensize;
  final DocumentSnapshot snap;
  Uint8List? profilePic;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: snap['uid'])
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(),
            );
          }
          return Stack(
            children: [
              SizedBox(
                height: screensize.height * 0.4,
                width: double.infinity,
              ),
              Container(
                height: screensize.height * 0.25,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: backgroundBoxcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                left: screensize.width / 2 / 2 / 1.45,
                top: screensize.height * 0.07,
                child: Container(
                  height: screensize.height * 0.290,
                  width: screensize.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screensize.height * 0.01,
                      ),
                      Container(
                        width: screensize.width * 0.2,
                        height: screensize.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(snap['profileImage'])),
                        ),
                      ),
                      SizedBox(
                        height: screensize.height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snap['username'],
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          snap['isPremium']
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                )
                              : Container(),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 2,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CountText(
                                count: snapshot.data!.docs.length.toString(),
                              ),
                              const TitleText(title: "Articles"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    FollowersPage(userId: snap['uid']),
                              ));
                            },
                            child: Column(
                              children: [
                                CountText(
                                  count: "${snap['followers'].length}",
                                ),
                                const TitleText(title: "Followers"),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FollowersPage(
                                  userId: snap['uid'],
                                  isFollowing: true,
                                ),
                              ));
                            },
                            child: Column(
                              children: [
                                CountText(
                                  count: "${snap['following'].length}",
                                ),
                                const TitleText(title: "Following"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Edit Profile"))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screensize.height * 0.125,
                left: screensize.width * 0.55,
                child: IconButton(
                    onPressed: () {
                      changeProfile(context);
                    },
                    icon: const Icon(Icons.add_a_photo)),
              ),
              Positioned(
                top: screensize.height * 0.010, 
                left: screensize.width * 0.80,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  SettingsPage(isPremium: snap['isPremium']),
                      ));
                    },
                    icon: const Icon(Icons.settings,color: Colors.white,)), 
              )
            ],
          );
        });
  }
changeProfile (BuildContext context) async {
                      await selectImage(context);
                      if (profilePic != null) {
                      String res=await  FirestoreMethods()
                            .changeProfileImage(snap['uid'], profilePic!);
                            if(res=="success"){
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                              const  SnackBar(
                                  content:  Text("Profile Image Changed"),
                                ),
                              );
                            }
                      }
                    }
  selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Change Profile Picture'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Uint8List file = await pickImage(ImageSource.camera);
                  profilePic = file;
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  try {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    profilePic = file;
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e.toString());
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
