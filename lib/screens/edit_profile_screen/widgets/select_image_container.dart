import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/edit_profile_provider.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectImageContainer extends StatelessWidget {
  const SelectImageContainer({
    super.key,
    required this.provider,
    required this.user,
    required this.screenSize,
  });

  final EditProfileProvider provider;
  final UserModel user;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        provider.isImageChanged
            ? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(provider.getFile!),
              )
            : CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.profileImage),
              ),
        Positioned(
          top: screenSize.height * 0.07,
          left: screenSize.width * 0.18,
          child: IconButton(
              onPressed: () {
                selectImage(context);
              },
              icon: const Icon(Icons.add_a_photo_sharp)),
        )
      ],
    );
  }
   selectImage(BuildContext parentContext) async {
    final provider =
        Provider.of<EditProfileProvider>(parentContext, listen: false);
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Change Profile Picture'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Uint8List file = await pickImage(ImageSource.camera);
                  provider.setImage = file;
                  provider.isImageChanged = true;
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  try {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    provider.setImage = file;
                    provider.isImageChanged = true;
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } catch (e) {
                    if (kDebugMode) {
                      print(e.toString());
                    }
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}