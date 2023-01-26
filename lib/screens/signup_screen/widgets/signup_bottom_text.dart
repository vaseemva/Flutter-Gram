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
            navigateToSignin(context);
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

  navigateToSignin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => SigninScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
