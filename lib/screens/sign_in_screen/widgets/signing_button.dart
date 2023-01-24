import 'package:flutter/material.dart';

class SigningButton extends StatelessWidget {
  const SigningButton({
    Key? key,
    required this.size, required this.buttonText, required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            onPressed();
          }, child: Text(buttonText)),
    );
  }
}