import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_card.dart';

class AllEventsStream extends StatelessWidget {
  const AllEventsStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
        stream: FirestoreMethods().getEventsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No Events'));
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return EventCard(model: snapshot.data![index],);
              },
              itemCount: snapshot.data!.length,
            ),
          );
        });
  }
}

