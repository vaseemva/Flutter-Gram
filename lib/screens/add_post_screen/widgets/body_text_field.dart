import 'package:flutter/material.dart';

class BodyTextField extends StatelessWidget {
  const BodyTextField({
    super.key,
    required TextEditingController bodyController,
  }) : _bodyController = bodyController;

  final TextEditingController _bodyController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: TextFormField(
        controller: _bodyController,
        minLines: 13,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

