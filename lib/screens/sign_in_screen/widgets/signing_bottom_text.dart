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
            navigateToSignup(context);
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

  navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
