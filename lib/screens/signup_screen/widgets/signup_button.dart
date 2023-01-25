import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 50,
      child: ElevatedButton(onPressed: () {}, child: const Text("Sign Up")),
    );
  }
}
