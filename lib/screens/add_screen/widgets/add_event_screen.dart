import 'dart:typed_data';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/add_event_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/add_screen/widgets/steps.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatelessWidget {
  AddEventScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add an Event"),
        ),
        body: Consumer<AddEventProvider>(
            builder: (context, provider, child) => Stepper(
                  currentStep: provider.currentStep,
                  onStepContinue: () {
                    provider.currentStep += 1;
                    provider.isLaststep = provider.currentStep == 6;
                  },
                  onStepCancel: () {
                    if (provider.currentStep == 6) {
                      provider.isLaststep = false;
                    }
                    provider.currentStep == 0
                        ? null
                        : provider.currentStep -= 1;
                  },
                  onStepTapped: (value) {
                    provider.currentStep = value;
                    if (value < 6) {
                      provider.isLaststep = false;
                    } else {
                      provider.isLaststep = true;
                    }
                  },
                  steps: getSteps(provider, size, context,
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                      locationController: _locationController),
                  controlsBuilder: (context, controlsDetails) {
                    return Column(
                      children: [
                        kHeight10,
                        Row(
                          children: [
                            provider.isLaststep
                                ? ElevatedButton(
                                    onPressed: () {
                                      postEvent(
                                          context,
                                          _titleController.text,
                                          _descriptionController.text,
                                          _locationController.text,
                                          provider.dateTime,
                                          provider.eventType,
                                          provider.getFile,
                                          provider.timeOfDay,
                                          user.uid);
                                    },
                                    child: provider.loading == 'yes'
                                        ? const CircularProgressIndicator()
                                        : const Text('Create'))
                                : ElevatedButton(
                                    onPressed: () {
                                      controlsDetails.onStepContinue!();
                                    },
                                    child: const Text('Next')),
                            kwidth15,
                            provider.currentStep == 0
                                ? const SizedBox()
                                : ElevatedButton(
                                    onPressed: () {
                                      controlsDetails.onStepCancel!();
                                    },
                                    child: const Text('Back'))
                          ],
                        ),
                      ],
                    );
                  },
                )));
  }

  postEvent(
    BuildContext context,
    String title,
    String description,
    String location,
    DateTime dateTime,
    String eventType,
    Uint8List? file,
    TimeOfDay eventTime,
    String uid,
  ) async {
    final provider = Provider.of<AddEventProvider>(context, listen: false);

    if (provider.getFile != null &&
        _descriptionController.text.isNotEmpty &&
        _titleController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      provider.loading = 'yes';
      try {
        String res = await FirestoreMethods().uploadEvent(title, description,
            location, dateTime, eventType, file!, eventTime, uid);
        if (res == 'success') {
          provider.loading = 'no';
          provider.currentStep = 0;
          provider.isLaststep = false;

          // ignore: use_build_context_synchronously
          showSnackBar("Event Created", context);
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
}
