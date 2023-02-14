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
          title:
              isFollowing ? const Text('Following') : const Text('Followers'),
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
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: FirestoreMethods()
                          .getUserDataF(snapshot.data![index]),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                          uid: snapshot.data!['uid'],
                                        )));
                          },
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data!['profileImage']),
                              ),
                              title: Text(snapshot.data!['username'])),
                        );
                      });
                });
          },
        ));
  }
}
