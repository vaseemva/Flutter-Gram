import 'package:flutter/material.dart';

class SettingSubTitle extends StatelessWidget {
  const SettingSubTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
