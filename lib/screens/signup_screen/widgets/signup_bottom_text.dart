import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
import 'package:flutter_gram/utils/constants.dart';

class SignUpBottomText extends StatelessWidget {
  const SignUpBottomText({
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SigninScreen(),
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
