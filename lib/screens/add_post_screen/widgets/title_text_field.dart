import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: const BoxDecoration(),
        padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8.0),
          ),
        ));
  }
}
