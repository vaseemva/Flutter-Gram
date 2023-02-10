import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/article_screeen.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:get_time_ago/get_time_ago.dart';

class SearchPostCard extends StatelessWidget {
  const SearchPostCard({
    super.key,
    required this.screenSize,
    required this.data,
  });

  final Size screenSize;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleScreeen(
            snap: data,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          color: templateTheme,
          child: ListTile(
            leading: Container(
              height: screenSize.height * 0.1,
              width: screenSize.width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data['postUrl']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.height * 0.05,
                      width: screenSize.width * 0.05,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data['profileImage']),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(data['fullName']),
                  ],
                ),
                Text(data['title']),
              ],
            ),
            subtitle: Text(GetTimeAgo.parse(data['datePublished'].toDate())),
          ),
        ),
      ),
    );
  }
}
