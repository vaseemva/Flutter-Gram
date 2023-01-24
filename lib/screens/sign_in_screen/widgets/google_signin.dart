import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleSignin extends StatelessWidget {
  const GoogleSignin({
    Key? key,
    required this.size, required this.onPressed,
  }) : super(key: key);

  final Size size;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: size.width * 0.8,
        child: SignInButton(
          Buttons.Google,
          onPressed: onPressed,
          elevation: 5.0,
        ));
  }
}


