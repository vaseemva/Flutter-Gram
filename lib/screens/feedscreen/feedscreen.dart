import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_card.dart';

class Feedscreen extends StatelessWidget {
  const Feedscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Scaffold(
    //   body: Center(child: PostCard(),)
    // );
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) =>
                PostCard(snap: snapshot.data!.docs[index].data()),
          ),
        );
      },
    );
  }
}
