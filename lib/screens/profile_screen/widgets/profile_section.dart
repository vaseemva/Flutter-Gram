import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/count_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/title_text.dart';
import 'package:flutter_gram/utils/colors.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.screensize,
    required this.snap,
  });

  final Size screensize;
  final DocumentSnapshot snap;

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
                height: screensize.height * 0.5,
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
                left: screensize.width * 0.075,
                top: screensize.height * 0.08,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screensize.height * 0.02,
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.GlIuUj-GYrRL_G8WvZ3YagHaHw?w=189&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7")),
                        ),
                      ),
                      SizedBox(
                        height: screensize.height * 0.01,
                      ),
                      Text(
                        snap['username'],
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 25,
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
                          Column(
                            children: [
                              CountText(
                                count: "${snap['followers'].length}",
                              ),
                              const TitleText(title: "Followers"),
                            ],
                          ),
                          Column(
                            children: [
                              CountText(
                                count: "${snap['following'].length}",
                              ),
                              const TitleText(title: "Following"),
                            ],
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
                top: screensize.height * 0.2,
                left: screensize.width * 0.55,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
              )
            ],
          );
        });
  }
}
