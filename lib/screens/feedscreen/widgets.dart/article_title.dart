import 'package:flutter/material.dart';

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    super.key,
    required this.snap,
  });

  final  snap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Text(
        snap['title'],
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
