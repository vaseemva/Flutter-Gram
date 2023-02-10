import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/comment_screen/comment_screen.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:share_plus/share_plus.dart';

class PostActionRow extends StatelessWidget {
  const PostActionRow({
    super.key,
    required this.size,
    required this.snap,
  });

  final Size size;
  final  snap;
  
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(snap['postId'])
            .collection('comments')
            .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return const Center(child: SizedBox());
        }
        return Padding(
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
             
            ],
          ),
        );
      }
    );
  }
}
