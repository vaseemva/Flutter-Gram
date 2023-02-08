import 'package:flutter/material.dart';

class CountText extends StatelessWidget {
  const CountText({
    super.key,
    required this.count,
  });
  final String count;
  @override
  Widget build(BuildContext context) {
    return Text(
      count,
      style: const TextStyle(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
    );
  }
}