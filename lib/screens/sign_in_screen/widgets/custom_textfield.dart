import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    required TextEditingController emailController,
  }) : _emailController = emailController, super(key: key);

  final Size size;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 50,
      child: TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            // hintText: 'Email' ,
            labelText: 'Email'),
      ),
    );
  }
}