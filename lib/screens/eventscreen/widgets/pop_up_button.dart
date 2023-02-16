import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/delete_event.dart';

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    super.key,
    required this.model,
  });

  final EventModel model;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: (value) {
          // handle the selected option
          switch (value) {
            case 'option1':
              // do something for option 1
              deleteEvent(context, model.eventId);
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'option1',
            child: Text('Delete Event'),
          ),
        ],
      );
  }
}
