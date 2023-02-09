import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/comment_screen/comment_screen.dart';
import 'package:flutter_gram/screens/feedscreen/article_screeen.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, this.snap}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(snap['postId'])
            .collection('comments')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(),
            );
          }
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticleScreeen(
                        snap: snap,
                      )));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                            .copyWith(right: 0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(snap['profileImage']),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap['fullName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: ListView(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            shrinkWrap: true,
                                            children: ["Hide"]
                                                .map((e) => InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 12,
                                                                horizontal: 16),
                                                        child: Text(e),
                                                      ),
                                                    ))
                                                .toList()),
                                      ));
                            },
                            icon: const Icon(Icons.more_vert))
                      ],
                    ),
                  ),
                  //title section
                  Text(
                    snap['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  //Thumbnail section
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: size.height * 0.25,
                      child: Image.network(
                        snap['postUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //upvote,comment section
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        IconButton(
                            onPressed: () async {
                              await FirestoreMethods().likePost(snap['postId'],
                                  currentUserUid!, snap['likes']);
                            },
                            icon: snap['likes'].contains(currentUserUid)
                                ? const Icon(Icons.arrow_circle_down)
                                : const Icon(Icons.arrow_circle_up)),
                        Text('${snap['likes'].length}'),
                        kwidth15,
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                        snap: snap,
                                      )));
                            },
                            icon: const Icon(Icons.comment_outlined)),
                        Text(snapshot.data!.docs.length.toString()),
                        kwidth15,
                        IconButton(
                            onPressed: () async {
                              await Share.share(
                                  "*${snap['title']}*\n${snap['body']}");
                            },
                            icon: const Icon(Icons.share_outlined)),
                        const Expanded(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(Icons.bookmark_border)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
