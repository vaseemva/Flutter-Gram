import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    required TextEditingController controller,
    required this.inputType, required this.labelText,this.obscure=false
  })  : _controller = controller,
        super(key: key);

  final Size size;
  final TextEditingController _controller;
  final TextInputType inputType;
  final String labelText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 50,
      child: TextFormField(
        controller: _controller,
        keyboardType: inputType,
        obscureText: obscure,
        decoration:  InputDecoration(
            border:const OutlineInputBorder(), labelText: labelText),
      ),
    );
  }
}
