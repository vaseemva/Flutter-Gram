import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/eventscreen/event_participants_screen.dart';

class EventActions extends StatelessWidget {
  const EventActions({
    super.key,
    required this.model,
    required this.user,
    required this.screenSize,
  });

  final EventModel model;
  final UserModel user;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: FirestoreMethods().isJoinedEvent(model.eventId, user.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return Container(
            height: screenSize.height * 0.075,
            width: screenSize.width,
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (snapshot.data!)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          FirestoreMethods()
                              .leaveEvent(model.eventId, user.uid);
                        },
                        child: const Text('Leave Event'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          FirestoreMethods()
                              .joinEvent(model.eventId, user.uid);
                        },
                        child: const Text('Join Event'),
                      ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EventParticipantsScreen(model: model),
                    ));
                  },
                  child: const Text('View Participants'),
                ),
              ],
            ),
          );
        });
  }
}

