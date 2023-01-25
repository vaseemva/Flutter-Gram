import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/signup_screen/signup_screen.dart';
import 'package:flutter_gram/utils/constants.dart';

class SigningBottomText extends StatelessWidget {
  const SigningBottomText({
    Key? key,
    required this.longText,
    required this.buttonText,
  }) : super(key: key);

  final String longText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth15,
        Text(longText),
        kwidth5,
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(),
                ));
          },
          child: Text(
            buttonText,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
