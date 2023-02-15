import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({
    super.key,
    required TextEditingController locationController,
  }) : _locationController = locationController;

  final TextEditingController _locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: TextFormField(
        controller: _locationController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8.0)),
      ),
    );
  }
}
