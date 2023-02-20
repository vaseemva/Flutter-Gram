import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/edit_post_provider.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class EditThumbnailContainer extends StatelessWidget {
  const EditThumbnailContainer({
    super.key,
    required this.size,
    required this.provider,
    required this.imageUrl,
  });

  final Size size;
  final EditPostProvider provider;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Uint8List file = await pickImage(ImageSource.gallery);

        provider.setImage = file;
        provider.isImageChanged = true;
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          width: size.width * 0.75,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.fill)),
        ),
      )),
    );
  }
}
