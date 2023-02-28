import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/articles_text.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/no_articles.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/other_user_pro_sec.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/profile_post_card.dart';
import 'package:flutter_gram/screens/profile_screen/widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: [
                uid == FirebaseAuth.instance.currentUser!.uid 
                    ? ProfileSection(
                        screensize: screensize, snap: snapshot.data!)
                    : OtherProfileSection(
                        screensize: screensize, snap: snapshot.data!),
                const ArticlesText(),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: uid)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            asyncsnapshot) {
                      if (!asyncsnapshot.hasData) {
                        return Center(child: Container());
                      }
                      if (asyncsnapshot.data!.docs.isEmpty) {
                        return const NoArticles();
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: asyncsnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = asyncsnapshot.data!.docs[index].data();

                            return ProfilePostCard(
                              snap: data,
                            );
                          });
                    }),
              ],
            );
          }),
    );
  }
}
