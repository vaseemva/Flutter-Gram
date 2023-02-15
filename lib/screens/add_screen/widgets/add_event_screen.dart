import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/add_event_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/add_screen/widgets/steps.dart';
import 'package:flutter_gram/utils/constants.dart';
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
                  onStepTapped: (value) => provider.currentStep = value,
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
                                    onPressed: () {},
                                    child: const Text('Create'))
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
}
