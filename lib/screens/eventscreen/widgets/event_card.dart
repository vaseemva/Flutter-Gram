import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_detail_screen.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.model,
  });
  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventDetailScreen(model: model),
        ));
      },
      child: Card(
        child: ListTile(
          leading: SizedBox(
              height: 100,
              width: 80,
              child: Image.network(
                model.imageUrl,
                fit: BoxFit.fill,
              )),
          title: Text(model.title),
          subtitle: Row(
            children: [
              Text(DateFormat.yMMMd().format(model.dateTime.toDate())),
              kwidth15,
              Text(TimeOfDay.fromDateTime(model.eventTime.toDate())
                  .format(context)),
            ],
          ),
        ),
      ),
    );
  }
}
