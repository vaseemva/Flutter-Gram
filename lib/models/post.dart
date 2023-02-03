import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;

  final String title;
  final String body;
  final String postUrl;
  final String fullName;
  final datePublished;
  final String postId;
  final String profileImage;
  final likes;

  Post({
    required this.fullName,
    required this.uid,
    required this.title,
    required this.body,
    required this.postUrl,
    required this.datePublished,
    required this.postId,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "uid": uid,
        "fullName": fullName,
        "body": body,
        "datePublished": datePublished,
        "postId": postId,
        "profileImage": profileImage,
        "likes": likes,
        "postUrl": postUrl
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        title: snapshot['title'],
        uid: snapshot['uid'],
        fullName: snapshot['fullName'],
        body: snapshot['body'],
        postUrl: snapshot["postUrl"],
        datePublished: snapshot["datePublished"],
        postId: snapshot["postId"],
        profileImage: snapshot["profileImage"],
        likes: snapshot["likes"]);
  }
}
