 import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/add_event_provider.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/body_text_field.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/title_text_field.dart';
import 'package:flutter_gram/screens/add_screen/widgets/location_text_field.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/poster_container.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/poster_image_container.dart';
import 'package:intl/intl.dart';

List<Step> getSteps(
    AddEventProvider provider,
    Size size,
    BuildContext context, {
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController locationController,
  }) {
    return [
      Step(
        title: const Text('Add Title'),
        content: TitleTextField(titleController: titleController),
        isActive: provider.currentStep >= 0,
        state:
            provider.currentStep > 0 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text('Add Description'),
        content: BodyTextField(bodyController: descriptionController),
        isActive: provider.currentStep >= 1,
        state:
            provider.currentStep > 1 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text('Add Date'),
        content: Row(
          children: [
            Text(DateFormat.yMMMMd().format(provider.dateTime)),
            TextButton.icon(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: provider.dateTime,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2040))
                      .then((value) {
                    if (value != null) {
                      provider.dateTime = value;
                    }
                  });
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Select'))
          ],
        ),
        isActive: provider.currentStep >= 2,
        state:
            provider.currentStep > 2 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text("Add Starting Time"),
        content: Row(
          children: [
            Text(provider.timeOfDay.format(context)),
            TextButton.icon(
                onPressed: () {
                  showTimePicker(
                          context: context, initialTime: provider.timeOfDay)
                      .then((value) {
                    if (value != null) {
                      provider.timeOfDay = value;
                    }
                  });
                },
                icon: const Icon(Icons.access_time),
                label: const Text("Select"))
          ],
        ),
        isActive: provider.currentStep >= 3,
        state:
            provider.currentStep > 3 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text("Event Type"),
        content: DropdownButton<String>(
            value: provider.eventType,
            items: const [
              DropdownMenuItem<String>(
                value: "Online",
                child: Text("Online"),
              ),
              DropdownMenuItem<String>(
                value: "In Person",
                child: Text("In Person"),
              ),
            ],
            onChanged: (value) {
              provider.eventType = value!;
            }),
        isActive: provider.currentStep >= 4,
        state:
            provider.currentStep > 4 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text("Location or Link"),
        content: LocationTextField(locationController: locationController),
        isActive: provider.currentStep >= 5,
        state:
            provider.currentStep > 5 ? StepState.complete : StepState.editing,
      ),
      Step(
        title: const Text('Add Poster'),
        content: provider.getFile == null
            ? PosterContainer(size: size, provider: provider)
            : PosterImageContainer(
                size: size,
                provider: provider,
              ),
        isActive: provider.currentStep >= 6,
        state:
            provider.currentStep > 6 ? StepState.complete : StepState.editing,
      ),
    ];
  }

