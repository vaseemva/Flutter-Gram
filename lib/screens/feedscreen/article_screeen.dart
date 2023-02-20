import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/edit_post_screen/edit_post_screen.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/body_text.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/name_and_date.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_action_row.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/thumbnail_widget.dart';
import 'package:provider/provider.dart';

class ArticleScreeen extends StatelessWidget {
  const ArticleScreeen({Key? key, this.snap}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(snap['postId'])
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(),
                );
              }
              return ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  //create a row of username and profile image and date published
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          snap['profileImage'],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      NameandDate(snap: snap),
                      const Expanded(child: SizedBox()),
                      snap['uid'] == (user.uid)
                          ? PopupMenuButton<String>(
                              onSelected: (value) {
                                // handle the selected option
                                switch (value) {
                                  case 'option1':
                                    // do something for option 1
                                    deletePost(context);
                                    break;
                                  case 'option2':
                                    // final provider =
                                    //     Provider.of<EditPostProvider>(context,listen: false) ;
                                    //        provider.setImage = snap['postUrl'];
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditPostScreen(
                                        snap: snap,
                                      ),
                                    ));
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'option1',
                                  child: Text('Delete Post'),
                                ),
                                const PopupMenuItem(
                                  value: 'option2',
                                  child: Text('Edit Post'),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  PostActionRow(size: size, snap: snapshot.data),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      snap['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ThumbnailWidget(size: size, snap: snap),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  BodyText(snap: snap),
                ],
              );
            }));
  }

  Future<dynamic> deletePost(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Are you sure you want to delete this event?'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FirestoreMethods().deletePost(snap['postId']);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
          ],
        ),
      ),
    );
  }
}
