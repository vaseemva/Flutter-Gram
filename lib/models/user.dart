import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String emailAddress;
  final String uid;

  final String username;
  final List followers;
  final List following;
  final String profileImage;
  final bool isPremium;
  final List chattedUsers;
  final List savedPosts;

  UserModel(
      {required this.emailAddress,
      required this.uid,
      required this.username,
      required this.followers,
      required this.following,
      required this.profileImage,
      this.isPremium=false,
      required this.chattedUsers,
      required this.savedPosts });

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "uid": uid,
        "username": username,
        "followers": followers,
        "following": following,
        "profileImage": profileImage,
        "isPremium": isPremium,
        "chattedUsers": chattedUsers,
        "savedPosts": savedPosts
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        emailAddress: snapshot['emailAddress'],
        uid: snapshot['uid'],
        username: snapshot['fullName'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        profileImage: snapshot['profileImage'],
        isPremium: snapshot['isPremium'],
        chattedUsers: snapshot['chattedUsers'],
        savedPosts: snapshot['savedPosts']);
  }
}
