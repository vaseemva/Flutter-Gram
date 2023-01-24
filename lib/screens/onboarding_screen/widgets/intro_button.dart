import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  const IntroButton({
    Key? key,
    required this.ontap,
    required this.buttonText,
  }) : super(key: key);

  final Function ontap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(buttonText),
      onTap: () {
        ontap();
      },
    );
  }
}
