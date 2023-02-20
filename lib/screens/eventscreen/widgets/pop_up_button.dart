import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/delete_event.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/edit_event/edit_event_screen.dart';

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
        switch (value) {
          case 'option1':
            deleteEvent(context, model.eventId);
            break;
          case 'option2':
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditEventScreen(model: model,)));
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'option1',
          child: Text('Delete Event'),
        ),
        const PopupMenuItem(value: "option2", child: Text("Edit Event"))
      ],
    );
  }
}
