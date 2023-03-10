import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/chat_screen/chat_detail_screen.dart';
import 'package:flutter_gram/utils/utils.dart';

class UserMessageRow extends StatelessWidget {
  const UserMessageRow({
    super.key,
    required this.uid,
    required this.email,
    required this.username,
    required this.profileImage,
  });
  final String uid;
  final String email;
  final String username;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: FirestoreMethods()
            .isFollowedStream(uid, FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    sendMail(email);
                  },
                  icon: const Icon(
                    Icons.mail,
                    size: 30,
                    color: Colors.blueGrey,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(
                        chatWith: uid,
                        username: username,
                        profileImage: profileImage,
                      ),
                    ));
                  },
                  icon: const Icon(
                    Icons.message,
                    size: 30,
                    color: Colors.blueGrey,
                  )),
              ElevatedButton.icon(
                  onPressed: () async {
                    await FirestoreMethods().followUser(
                        FirebaseAuth.instance.currentUser!.uid, uid);
                  },
                  icon: Icon((snapshot.data!)
                      ? Icons.person_remove
                      : Icons.person_add),
                  label: (snapshot.data!)
                      ? const Text('Unfollow')
                      : const Text('Follow'))
            ],
          );
        });
  }
}
