import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage(
      {Key? key, required this.userId, this.isFollowing = false})
      : super(key: key);
  final String userId;
  final bool isFollowing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Followers'),
        ),
        body: StreamBuilder(
          stream: isFollowing
              ? FirestoreMethods().getFollowingStream(userId)
              : FirestoreMethods().getFollowersStream(userId),
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: isFollowing
                    ? const Text('No Following')
                    : const Text('No Followers'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: snapshot.data![index])
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            asyncsnapshot) {
                      if (!asyncsnapshot.hasData) {
                        return Center(
                          child: Container(),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                uid: asyncsnapshot.data!.docs[index]
                                    .data()['uid']),
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(asyncsnapshot
                                .data!.docs[index]
                                .data()['profileImage']),
                          ),
                          title: Text(asyncsnapshot.data!.docs[index]
                              .data()['username']),
                        ),
                      );
                    });
              },
            );
          },
        ));
  }
}
