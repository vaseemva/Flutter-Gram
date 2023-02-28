import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/eventscreen/event_participants_screen.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

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
          return SizedBox(
            height: screenSize.height * 0.075,
            width: screenSize.width,
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
                          FirestoreMethods().joinEvent(model.eventId, user.uid);
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
                IconButton(
                    onPressed: () async {
                      await Share.share(
                          'Hey, check out this event on Flutter Gram:\n *${model.title}* at *${model.location}* on ${DateFormat.yMMMMd().format(model.dateTime.toDate())} at ${DateFormat.Hm().format((model.eventTime.toDate()))}!,Lets join together and have fun!');
                    },
                    icon:const Icon(
                      Icons.share,
                      color: Colors.blue,
                    ))
              ],
            ),
          );
        });
  }
}
