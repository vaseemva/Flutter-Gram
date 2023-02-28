import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/article_title.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/body_text.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/name_and_date.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/popup_for_article.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_action_row.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/thumbnail_widget.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(uid: snap['uid']),
                          ));
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snap['profileImage'],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      NameandDate(snap: snap),
                      const Expanded(child: SizedBox()),
                      snap['uid'] == (user.uid)
                          ? PopUpForArticle(snap: snap) //if the user is the owner of the post, show the popup menu
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  PostActionRow(size: size, snap: snapshot.data),
                  ArticleTitle(snap: snap),
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
}
