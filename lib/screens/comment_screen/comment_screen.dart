import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/field_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/comment_screen/widgets/comment_card.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, this.snap}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  final snap;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(snap['postId'])
            .collection("comments")
            .orderBy("datePublished", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return  Center(
              child: Text(commentEmpty), 
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return CommentCard(
                snap: (snapshot.data! as dynamic).docs[index],
                postId: snap['postId'],
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Consumer<FieldProvider>(
                        builder: (context, value, child) => TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "Comment as $currentUserName",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await FirestoreMethods().postComment(
                          snap['postId'],
                          currentUserUid!,
                          currentUserName!,
                          user.profileImage,
                          _commentController.text);
                      _commentController.text = "";
                    },
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ))),
    );
  }
}
