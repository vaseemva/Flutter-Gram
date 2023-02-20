
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/edit_event_provider.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class EditFileContainer extends StatelessWidget {
  const EditFileContainer({
    super.key,
    required this.size,
    required this.provider,
  });

  final Size size;
  final EditEventProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          Uint8List file = await pickImage(ImageSource.gallery);

          provider.setImage = file;
        },
        child: Container(
          width: size.width * 0.75,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(provider.getFile!), fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
