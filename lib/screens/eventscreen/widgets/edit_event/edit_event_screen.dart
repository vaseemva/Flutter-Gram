import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/edit_event_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/edit_event/edit_functions.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/edit_event/get_edit_steps.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({Key? key, required this.model}) : super(key: key);
  final EventModel model;

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EditEventProvider>(context, listen: false).dateTime =
          (widget.model.dateTime.toDate());
      Provider.of<EditEventProvider>(context, listen: false).timeOfDay =
          TimeOfDay.fromDateTime(widget.model.eventTime.toDate());
      Provider.of<EditEventProvider>(context, listen: false).eventType =
          (widget.model.eventType);
    });
    _titleController.text = widget.model.title;
    _descriptionController.text = widget.model.description;
    _locationController.text = widget.model.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add an Event"),
        ),
        body: Consumer<EditEventProvider>(
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
                  steps: getSteps(
                      provider, size, widget.model.imageUrl, context,
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
                                      provider.isImageChanged
                                          ? editEventWithImage(
                                              context,
                                              _titleController.text,
                                              _descriptionController.text,
                                              _locationController.text,
                                              provider.dateTime,
                                              provider.eventType,
                                              provider.getFile,
                                              provider.timeOfDay,
                                              user.uid,
                                              widget.model.eventId,
                                              titleController: _titleController,
                                              descriptionController:
                                                  _descriptionController,
                                              locationController:
                                                  _locationController)
                                          : editEventWithoutImage(
                                              context,
                                              _titleController.text,
                                              _descriptionController.text,
                                              _locationController.text,
                                              provider.dateTime,
                                              provider.eventType,
                                              widget.model.imageUrl,
                                              provider.timeOfDay,
                                              user.uid,
                                              widget.model.eventId,
                                              titleController: _titleController,
                                              descriptionController:
                                                  _descriptionController,
                                              locationController:
                                                  _locationController);
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
}
