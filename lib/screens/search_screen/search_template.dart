import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/search_screen/search_screen.dart';
import 'package:flutter_gram/screens/search_screen/widgets/search_postcard.dart';
import 'package:flutter_gram/screens/search_screen/widgets/trending_text.dart';
import 'package:flutter_gram/utils/colors.dart';

class SearchTemplate extends StatelessWidget {
  const SearchTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              fillColor: templateTheme,
              filled: true,
              hintText: '  Search',
              border: InputBorder.none,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              SizedBox(height: screenSize.height * 0.01),
             const TrendingText(),
              SizedBox(height: screenSize.height * 0.01),
              ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data();
                  return SearchPostCard(screenSize: screenSize, data: data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

