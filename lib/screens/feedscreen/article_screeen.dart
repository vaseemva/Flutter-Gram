import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/body_text.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/more_options.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/name_and_date.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_action_row.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/thumbnail_widget.dart';

class ArticleScreeen extends StatelessWidget {
  const ArticleScreeen({Key? key, this.snap}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
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
}
