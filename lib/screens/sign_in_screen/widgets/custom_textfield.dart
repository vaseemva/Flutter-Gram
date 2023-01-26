import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.size,
      required TextEditingController controller,
      required this.inputType,
      required this.labelText,
      this.obscure = false,
      required this.validator})
      : _controller = controller,
        super(key: key);

  final Size size;
  final TextEditingController _controller;
  final TextInputType inputType;
  final String labelText;
  final bool obscure;
  final FormFieldValidator<String?> validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      // height: 40,
      child: TextFormField(
        validator: validator,
        controller: _controller,
        keyboardType: inputType,
        obscureText: obscure,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}
