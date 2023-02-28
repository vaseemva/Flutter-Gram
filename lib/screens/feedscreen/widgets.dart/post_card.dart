import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/article_screeen.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/more_options.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_action_row.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, this.snap}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleScreeen(
                  snap: snap,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                uid: snap['uid'],
                              )));
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(snap['profileImage']),
                    ),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
                  MoreOptions(
                    uid: snap['uid'],
                    postId: snap['postId'],
                  )
                ],
              ),
            ),
            //title section
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16,),
              child: Text(
                snap['title'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
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
            PostActionRow(
              size: size,
              snap: snap,
            )
          ],
        ),
      ),
    );
  }
}
