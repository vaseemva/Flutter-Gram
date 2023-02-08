import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/articles_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/profile_post_card.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/profile_section.dart';
import 'package:flutter_gram/utils/global.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .get(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where('uid', isEqualTo: currentUserUid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        asyncsnapshot) {
                  if (!asyncsnapshot.hasData) {
                    return  Center(child: Container());
                  }

                  return ListView(
                    children: [
                      ProfileSection(
                          screensize: screensize, snap: snapshot.data!),
                      const ArticlesText(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: asyncsnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                           final data=asyncsnapshot.data!.docs[index].data();
                            return ProfilePostCard(snap: data,);
                          } ),
                    ],
                  );
                });
          }),
    );
  }
}
