import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/add_event_provider.dart';

import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class PosterContainer extends StatelessWidget {
  const PosterContainer({
    super.key,
    required this.size, required this.provider,
  });

  final Size size;
  final AddEventProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Uint8List file = await pickImage(ImageSource.gallery);

          provider.setImage = file;
        },
        child: Center(
          child: Container(
            width: size.width * 0.75, 
            height: size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                      0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.upload),
                kHeight10,
                Text('Add a Poster') 
              ],
            ),
          ),
        ));
  }
}
