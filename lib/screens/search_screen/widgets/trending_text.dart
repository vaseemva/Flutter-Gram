import 'package:flutter/material.dart';

class TrendingText extends StatelessWidget {
  const TrendingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: const Icon(Icons.trending_up_outlined),
        ),
        const SizedBox(width: 10),
        const Text('Trending  on FlutterGram',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
