import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/article_screeen.dart';
import 'package:intl/intl.dart';

class ProfilePostCard extends StatelessWidget {
  const ProfilePostCard({super.key, required this.snap});

  final snap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleScreeen(
            snap: snap,
          ),
        ));
      },
      child: ListTile(
        leading: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(snap['postUrl']), fit: BoxFit.cover)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              snap['title'],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              DateFormat.yMMMMd().format(snap['datePublished'].toDate()),
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
