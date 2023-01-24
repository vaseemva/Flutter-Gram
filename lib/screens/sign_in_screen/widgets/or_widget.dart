import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.4,
        ),
        const Text(
          'OR',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
