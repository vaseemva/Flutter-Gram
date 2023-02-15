import 'package:cloud_firestore/cloud_firestore.dart';


class EventModel {
  final String title;
  final String description;
  final String location;
  final dateTime;
  final String eventType;
  final String imageUrl;
  final  eventTime;
  final String uid;
  final String eventId;

  EventModel({
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.eventType,
    required this.imageUrl,
    required this.eventTime,
    required this.uid,
    required this.eventId,
  });
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "dateTime": dateTime,
        "eventType": eventType,
        "imageUrl": imageUrl,
        "eventTime": eventTime,
        "uid": uid,
        "eventId": eventId,
      };

  static EventModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return EventModel(
      title: snapshot["title"],
      description: snapshot["description"],
      location: snapshot["location"],
      dateTime: snapshot["dateTime"],
      eventType: snapshot["eventType"],
      imageUrl: snapshot["imageUrl"],
      eventTime: snapshot["eventTime"],
      uid: snapshot["uid"],
      eventId: snapshot["eventId"],
    );
  }
}
