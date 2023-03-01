import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';

class MoreOptions extends StatelessWidget {
  MoreOptions({
    super.key,
    required this.uid,
    required this.postId,
    this.isArticle = false,
  });
  final String uid;
  final String postId;
  final bool isArticle;
  final String currentUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                      child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: [
                        uid == currentUid
                            ? InkWell( 
                                onTap: () {
                                  Navigator.of(context).pop();
                                  deletePost(postId, context, isArticle);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child: const Text('delete'),
                                ),
                              )
                            : const SizedBox(),
                            
                        GestureDetector(
                          onTap: () async {
                            String res =
                                await FirestoreMethods().saveePost(postId, currentUid); 
                            if (res == 'added') {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Post saved'),
                                ),
                              );
                            }
                            if (res == 'removed') {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Removed from saved'),
                                ),
                              );
                            }
                          },
                          child: 
                          StreamBuilder(
                              stream: FirestoreMethods()
                                  .checkIfPostIsSaved(postId, currentUid), 
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child:
                                   (snapshot.data!)
                                      ? const Text('Remove from saved') 
                                      : 
                                      const Text('Save'),
                                );
                              }),
                        ),
                      ])));
        },
        icon: const Icon(Icons.more_vert));
  }

  deletePost(String postId, BuildContext context, bool isArticle) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Are you sure you want to delete this post?'),
              ),
              InkWell(
                onTap: () {
                  FirestoreMethods().deletePost(postId);
                  Navigator.of(context).pop();
                  isArticle ? Navigator.of(context).pop() : null;
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: const Text('delete'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
