import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/post.dart';
import 'package:flutter_gram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String title,
    String body,
    String uid,
    Uint8List file,
    String fullName,
    String profileImage,
  ) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImagetoStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          fullName: fullName,
          uid: uid,
          title: title,
          body: body,
          postUrl: photoUrl,
          datePublished: DateTime.now(),
          postId: postId,
          profileImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //add event
  Future<String> uploadEvent(
    String title,
    String description,
    String location,
    DateTime dateTime,
    String eventType,
    Uint8List file,
    TimeOfDay eventTime,
    String uid,
  ) async {
    String res = 'some error occured';
    try {
      String imageUrl =
          await StorageMethods().uploadImagetoStorage('events', file, true);
      String eventId = const Uuid().v1();
      final DateTime now = DateTime.now();
      final DateTime timestamp = DateTime(
          now.year, now.month, now.day, eventTime.hour, eventTime.minute);
      EventModel event = EventModel(
        title: title,
        description: description,
        location: location,
        dateTime: dateTime,
        eventType: eventType,
        imageUrl: imageUrl,
        eventTime: Timestamp.fromDate(timestamp),
        uid: uid,
        eventId: eventId,
      );
      _firestore.collection('events').doc(eventId).set(event.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //edit event without image
  Future<String> editEvent(
    String title,
    String description,
    String location,
    DateTime dateTime,
    String eventType,
    // Uint8List file,
    String imageUrl,
    TimeOfDay eventTime,
    String uid,
    String eventId,
  ) async {
    String res = 'some error occured';
    try {
      // String imageUrl =
      //     await StorageMethods().uploadImagetoStorage('events', file, true);
      final DateTime now = DateTime.now();
      final DateTime timestamp = DateTime(
          now.year, now.month, now.day, eventTime.hour, eventTime.minute);
      EventModel event = EventModel(
        title: title,
        description: description,
        location: location,
        dateTime: dateTime,
        eventType: eventType,
        imageUrl: imageUrl,
        eventTime: Timestamp.fromDate(timestamp),
        uid: uid,
        eventId: eventId,
      );
      _firestore.collection('events').doc(eventId).update(event.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //edit event with image
  Future<String> editEventWithImage(
    String title,
    String description,
    String location,
    DateTime dateTime,
    String eventType,
    Uint8List file,
    TimeOfDay eventTime,
    String uid,
    String eventId,
  ) async {
    String res = 'some error occured';
    try {
      String imageUrl =
          await StorageMethods().uploadImagetoStorage('events', file, true);
      final DateTime now = DateTime.now();
      final DateTime timestamp = DateTime(
          now.year, now.month, now.day, eventTime.hour, eventTime.minute);
      EventModel event = EventModel(
        title: title,
        description: description,
        location: location,
        dateTime: dateTime,
        eventType: eventType,
        imageUrl: imageUrl,
        eventTime: Timestamp.fromDate(timestamp),
        uid: uid,
        eventId: eventId,
      );
      _firestore.collection('events').doc(eventId).update(event.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //like post
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //edit post without image
  Future<String> editPost(
    String title,
    String body,
    String uid,
    // Uint8List file,
    String photoUrl,
    String fullName,
    String profileImage,
    String postId,
  ) async {
    String res = 'some error occured';
    try {
      // String photoUrl =
      //     await StorageMethods().uploadImagetoStorage('posts', file, true);
      Post post = Post(
          fullName: fullName,
          uid: uid,
          title: title,
          body: body,
          postUrl: photoUrl,
          datePublished: DateTime.now(),
          postId: postId,
          profileImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).update(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //edit post with image
  Future<String> editPostWithImage(
    String title,
    String body,
    String uid,
    Uint8List file,
    String fullName,
    String profileImage,
    String postId,
  ) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImagetoStorage('posts', file, true);
      Post post = Post(
          fullName: fullName,
          uid: uid,
          title: title,
          body: body,
          postUrl: photoUrl,
          datePublished: DateTime.now(),
          postId: postId,
          profileImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).update(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //post comments
  Future<void> postComment(String postId, String uid, String name,
      String profileImage, String comment) async {
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'uid': uid,
          'name': name,
          'profileImage': profileImage,
          'comment': comment,
          'datePublished': DateTime.now()
        });
      } else {
        print('comment is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  //delete comment
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //delete post if the user is the owner
  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //change profile image
  Future<String> changeProfileImage(String uid, Uint8List file) async {
    String res = 'some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImagetoStorage('profile', file, false);
      _firestore.collection('users').doc(uid).update({
        'profileImage': photoUrl,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
      print(e.toString());
    }
    return res;
  }

  //follow user and unfollow user
  Future<void> followUser(String uid, String followingId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followingId)) {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followingId])
        });
        await _firestore.collection('users').doc(followingId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followingId])
        });
        await _firestore.collection('users').doc(followingId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<bool> isFollowedStream(String userId, String currentUserId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['following'])
                .contains(userId));
  }

  //get followers stream
  Stream<List<String>> getFollowersStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['followers']));
  }

  //get following stream
  Stream<List<String>> getFollowingStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['following']));
  }

  Stream<List<String>> getFollowers(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((documentSnapshot) =>
            List<String>.from(documentSnapshot.get('following')));
  }

  //get following count stream
  Stream<int> getFollowingCountStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['followers'])
                .length);
  }

  //delete post
  Future<void> deletePostFromFirestore(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //get user data from uid
  Future<Map<String, dynamic>> getUserDataF(String uid) async {
    Map<String, dynamic> userData = {};
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      userData = snap.data()! as dynamic;
    } catch (e) {
      print(e.toString());
    }
    return userData;
  }

  //premiun user
  Future<void> premiumUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'isPremium': true,
      });
    } catch (e) {
      print(e.toString());
    }
  }

//get events stream
  Stream<List<EventModel>> getEventsStream() {
    return _firestore
        .collection('events')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventModel.fromJson(doc.data()))
            .toList());
  }

  //get events stream
  Stream<List<EventModel>> getEventsStreamByType(String eventType) {
    return _firestore
        .collection('events')
        .where('eventType', isEqualTo: eventType)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventModel.fromJson(doc.data()))
            .toList());
  }

  //get events stream
  Stream<List<EventModel>> getEventsStreamByUid(String uid) {
    return _firestore
        .collection('events')
        .where('uid', isEqualTo: uid)
        .orderBy('eventTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EventModel.fromJson(doc.data()))
            .toList());
  }

  //join event
  Future<String> joinEvent(String eventId, String uid) async {
    String res = 'some error occured';
    try {
      await _firestore.collection('events').doc(eventId).update({
        'joinedUsers': FieldValue.arrayUnion([uid])
      });
      res = 'success';
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  //leave event
  Future<String> leaveEvent(String eventId, String uid) async {
    String res = 'some error occured';
    try {
      await _firestore.collection('events').doc(eventId).update({
        'joinedUsers': FieldValue.arrayRemove([uid])
      });
      res = 'success';
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  //get event participants
  Stream<List<String>> getEventParticipants(String eventId) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .snapshots()
        .map((documentSnapshot) =>
            List<String>.from(documentSnapshot.get('joinedUsers')));
  }

  //check if user joined event
  Stream<bool> isJoinedEvent(String eventId, String uid) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['joinedUsers'])
                .contains(uid));
  }

  //delete event
  Future<void> deleteEventFromFirestore(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //send message to a user
}
