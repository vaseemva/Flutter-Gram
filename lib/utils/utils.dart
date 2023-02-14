


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';


pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } 

  
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
Future<void> sendMail(String email) async {
  final Uri url = Uri.parse(
      'mailto:$email?subject=Connecting With You&body=');
  if (!await launchUrl(url)) {
    throw 'Could not launch';
  }
}
  