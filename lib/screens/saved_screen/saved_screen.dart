import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_card.dart';
import 'package:flutter_gram/utils/global.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: whiteAppBar('Saved Articles'),
      body: StreamBuilder(
        stream: FirestoreMethods().getSavedPosts(currentUserUid!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Saved Articles'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: FirestoreMethods().getPostById(snapshot.data![index]),
                builder: (context, secondsnapshot) {
                  if (!secondsnapshot.hasData) {
                    return const Center(
                      child: SizedBox(),
                    );
                  }

                  return PostCard(
                    snap: secondsnapshot.data,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  
}
