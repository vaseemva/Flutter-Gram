import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String emailAddress;
  final String uid;

  final String username;
  final List followers;
  final List following;

  UserModel(
      {required this.emailAddress,
      required this.uid,
      required this.username,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "uid": uid,
        "username": username,
        "followers": followers,
        "following": following
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        emailAddress: snapshot['emailAddress'],
        uid: snapshot['uid'],
        username: snapshot['fullName'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
