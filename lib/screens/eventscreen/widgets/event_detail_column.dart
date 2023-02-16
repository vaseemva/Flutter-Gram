import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/step_out_widget.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:intl/intl.dart';

class EventDetailColumn extends StatelessWidget {
  const EventDetailColumn({
    super.key,
    required this.model,
  });

  final EventModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold), 
                ), 
                Row(
                  children: [
                    Icon(
                      model.eventType == "Online"
                          ? Icons.video_call
                          : Icons.groups_2,
                      size: 30,
                    ),
                    kwidth15,
                    Text(
                      "${model.eventType} Event",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 30,
                    ),
                    kwidth15,
                    Text(
                      DateFormat.yMMMd().format(model.dateTime.toDate()),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                kHeight10,
                Row(
                  children: [
                    Text(
                      "Event Begins: ${TimeOfDay.fromDateTime(model.eventTime.toDate()).format(context)} Onwards",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                kHeight10,
                Row(
                  children: [
                    Icon(
                      model.eventType == "Online"
                          ? Icons.link
                          : Icons.location_on,
                      size: 30,
                    ),
                    kwidth15,
                    Text(model.location)
                  ],
                ),
                kHeight10,
               const StepOutWidget()
              ],
            )));
  }
}

