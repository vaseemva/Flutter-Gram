import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/followers_page/followers_page.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/count_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/title_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/user_message_row.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/user_name.dart';
import 'package:flutter_gram/utils/colors.dart';

class OtherProfileSection extends StatelessWidget {
  const OtherProfileSection({
    super.key,
    required this.screensize,
    required this.snap,
  });

  final Size screensize;
  final DocumentSnapshot snap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: FirestoreMethods().getFollowingCountStream(snap['uid']),
        builder: (context, countsnapshot) {
          if (!countsnapshot.hasData) {
            return Center(
              child: Container(),
            );
          }
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
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 139, 136, 136),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(180)),
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      snap['profileImage'],
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              height: screensize.height * 0.005,
                            ),
                            UserName(snap: snap),
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
                                      count:
                                          snapshot.data!.docs.length.toString(),
                                    ),
                                    const TitleText(title: "Articles"),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          FollowersPage(userId: snap['uid']),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      CountText(
                                        count: "${countsnapshot.data}",
                                      ),
                                      const TitleText(title: "Followers"),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
                            UserMessageRow(
                              uid: snap['uid'],
                              email: snap['emailAddress'],
                              username: snap['username'], 
                              profileImage: snap['profileImage'],

                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }
}

