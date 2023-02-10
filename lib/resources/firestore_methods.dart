import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  //delete post if the user is the owner
  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //change profile image
  Future<void> changeProfileImage(String uid, Uint8List file) async {
    try {
      String photoUrl =
          await StorageMethods().uploadImagetoStorage('profile', file, false);
      _firestore.collection('users').doc(uid).update({
        'profileImage': photoUrl,
      });
    } catch (e) {
      print(e.toString());
    }
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
  //get following count stream
  Stream<int> getFollowingCountStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) =>
            List<String>.from((snapshot.data()! as dynamic)['followers']).length);
  }
  
   
}
