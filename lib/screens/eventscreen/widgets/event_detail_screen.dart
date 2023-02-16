import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/eventscreen/event_participants_screen.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_detail_column.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key? key, required this.model}) : super(key: key);
  final EventModel model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
        appBar: AppBar(
          title: Text(model.title),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              height: screenSize.height * 0.3,
              width: screenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              thickness: 3,
              endIndent: 16,
              indent: 18,
            ),
            EventDetailColumn(model: model),
            kHeight20,
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "About Event",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Text(model.description),
            ),
          ],
        ),
        bottomNavigationBar: StreamBuilder<bool>(
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
            }));
  }
}
