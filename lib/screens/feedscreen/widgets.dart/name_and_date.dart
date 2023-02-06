import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NameandDate extends StatelessWidget {
  const NameandDate({
    super.key,
    required this.snap,
  });

  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          snap['fullName'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(DateFormat.yMMMd().format(snap['datePublished'].toDate()))
      ],
    );
  }
}
