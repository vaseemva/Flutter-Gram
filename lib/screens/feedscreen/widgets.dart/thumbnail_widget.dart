import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({
    super.key,
    required this.size,
    required this.snap,
  });

  final Size size;
  final snap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height * 0.2,
        width: size.width * 0.7,
        child: Image.network(snap['postUrl']));
  }
}

