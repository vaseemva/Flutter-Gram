import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/edit_profile_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    super.key,
    required this.screenSize,
    required this.provider, required this.uid,
  });

  final Size screenSize;
  final EditProfileProvider provider;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: screenSize.width * 0.24,
        ),
        SizedBox(
          width: screenSize.width * 0.7,
          child: provider.getLoading == 'Yes'
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (provider.isNameBioUpdated ||
                        provider.isImageChanged) {
                      if (provider.getName != null &&
                          provider.getBio != null &&
                          provider.isImageChanged == false) {
                        updateWithoutImage(
                            uid,
                            provider.getName!,
                            provider.getBio!,
                            context);
                      } else if (provider.getName != null &&
                          provider.getBio != null &&
                          provider.isImageChanged) {
                        updateWithImage(
                            uid,
                            provider.getName!,
                            provider.getBio!,
                            provider.getFile!,
                            context);
                      } else {
                        AnimatedSnackBar.material(
                                "Please fill empty fields",
                                type: AnimatedSnackBarType.error)
                            .show(context);
                      }
                    } else {
                      showSnackBar("Nothing to Update", context);
                    }
                  },
                  child: const Text('Update Profile')),
        ),
      ],
    );
  }
   updateWithImage(String uid, String username, String bio, Uint8List file,
      BuildContext context) async {
    final provider = Provider.of<EditProfileProvider>(context, listen: false);
    provider.setLoading = 'Yes';
    String res = await FirestoreMethods().changeProfileImage(uid, file);
    if (res == "success") {
      // ignore: use_build_context_synchronously
      await updateWithoutImage(uid, username, bio, context);
      provider.setLoading = 'No';
    }
  }

  updateWithoutImage(
      String uid, String username, String bio, BuildContext context) async {
    if (username.isNotEmpty && bio.isNotEmpty) {
      String res =
          await FirestoreMethods().updateUsernameAndBio(username, bio, uid);
      if (res == "success") {
        // ignore: use_build_context_synchronously
        showSnackBar("Updated successfully", context);
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).refreshUser();
      } else {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.material("Please fill empty fields",
                type: AnimatedSnackBarType.error)
            .show(context);
      }
    }
  }
}



