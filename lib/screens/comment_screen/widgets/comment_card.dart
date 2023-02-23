import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key, required this.snap, required this.postId})
      : super(key: key);
// ignore: prefer_typing_uninitialized_variables
  final snap;
  final postId;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () {
        snap['uid'] == user.uid
            ? showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: screensize.height * 0.08,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Delete'),
                          onTap: () {
                            FirestoreMethods()
                                .deleteComment(postId, snap['commentId']);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        color: snap['uid'] == user.uid ? Colors.grey[200] : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(snap["profileImage"]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: snap['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ])),
                      Text(GetTimeAgo.parse(snap['datePublished'].toDate()),
                          style: const TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screensize.width * 0.135,
                  right: screensize.width * 0.1),
              child: Text(
                snap['comment'],
                softWrap: true,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
