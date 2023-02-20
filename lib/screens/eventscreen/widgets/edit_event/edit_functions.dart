import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/edit_event_provider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:provider/provider.dart';

editEventWithImage(
  BuildContext context,
  String title,
  String description,
  String location,
  DateTime dateTime,
  String eventType,
  Uint8List? file,
  TimeOfDay eventTime,
  String uid,
  String eventId, {
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required TextEditingController locationController,
}) async {
  final provider = Provider.of<EditEventProvider>(context, listen: false);

  if (provider.getFile != null &&
      descriptionController.text.isNotEmpty &&
      titleController.text.isNotEmpty &&
      locationController.text.isNotEmpty) {
    provider.loading = 'yes';
    try {
      String res = await FirestoreMethods().editEventWithImage(
          title,
          description,
          location,
          dateTime,
          eventType,
          file!,
          eventTime,
          uid,
          eventId);
      if (res == 'success') {
        provider.loading = 'no';
        provider.currentStep = 0;
        provider.isLaststep = false;

        // ignore: use_build_context_synchronously
        showSnackBar("Event Updated", context);
      } else {
        provider.loading = 'no';

        // ignore: use_build_context_synchronously
        showSnackBar(res, context);
      }
    } catch (e) {
      print(e.toString());
    }
  } else {
    AnimatedSnackBar.material(
      "Please fill all fields",
      type: AnimatedSnackBarType.error,
    ).show(context);
    provider.changeIsLoading = false;
  }
}

editEventWithoutImage(
  BuildContext context,
  String title,
  String description,
  String location,
  DateTime dateTime,
  String eventType,
  String imageUrl,
  TimeOfDay eventTime,
  String uid,
  String eventId, {
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required TextEditingController locationController,
}) async {
  final provider = Provider.of<EditEventProvider>(context, listen: false);

  if (descriptionController.text.isNotEmpty &&
      titleController.text.isNotEmpty &&
      locationController.text.isNotEmpty) {
    provider.loading = 'yes';
    try {
      String res = await FirestoreMethods().editEvent(title, description,
          location, dateTime, eventType, imageUrl, eventTime, uid, eventId);
      if (res == 'success') {
        provider.loading = 'no';
        provider.currentStep = 0;
        provider.isLaststep = false;

        // ignore: use_build_context_synchronously
        showSnackBar("Event Updated", context);
      } else {
        provider.loading = 'no';

        // ignore: use_build_context_synchronously
        showSnackBar(res, context);
      }
    } catch (e) {
      print(e.toString());
    }
  } else {
    AnimatedSnackBar.material(
      "Please fill all fields",
      type: AnimatedSnackBarType.error,
    ).show(context);
    provider.changeIsLoading = false;
  }
}
