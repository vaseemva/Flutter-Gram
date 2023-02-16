import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';

class EventParticipantsScreen extends StatelessWidget {
  const EventParticipantsScreen({Key? key, required this.model})
      : super(key: key);

  final EventModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Event Participants'),
        ),
        body: StreamBuilder(
          stream: FirestoreMethods().getEventParticipants(model.eventId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Participants'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future:
                      FirestoreMethods().getUserDataF(snapshot.data![index]),
                  builder: (context, secondsnapshot) {
                    if (!secondsnapshot.hasData) {
                      return const Center(
                        child: SizedBox(),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                      uid: secondsnapshot.data!['uid'],
                                    )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              secondsnapshot.data!['profileImage']),
                        ),
                        title: Text(secondsnapshot.data!['username']),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
