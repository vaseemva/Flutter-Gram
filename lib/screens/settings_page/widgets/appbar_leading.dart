import 'package:flutter/material.dart';

class AppBarLeading extends StatelessWidget {
  const AppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [
    GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.keyboard_arrow_left_sharp,size: 24,)),    
    const Text('Back')
      ],
    );
  }
}
