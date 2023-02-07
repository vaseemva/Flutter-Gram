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
  Future<void> postComment(String postId, String uid,String name,String profileImage,String comment) async {
    try {
     if(comment.isNotEmpty){
      String commentId=const Uuid().v1();
      _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
        'commentId':commentId,
        'uid':uid,
        'name':name,
        'profileImage':profileImage,
        'comment':comment,
        'datePublished':DateTime.now() 
      });
     }else{
       print('comment is empty');
     }

    } catch (e) {
      print(e.toString());
    }
  }
}
