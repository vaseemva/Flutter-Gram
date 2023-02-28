import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        emailAddress: snapshot["emailAddress"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        profileImage: snapshot["profileImage"],
        chattedUsers: snapshot["chattedUsers"],
        savedPosts: snapshot["savedPosts"]);
  }

  //signing up user
  Future<String> signupUser(
      {required String username,
      required String emailAddress,
      required String password}) async {
    String res = 'some error occured';
    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          emailAddress.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: emailAddress, password: password);
        UserModel userModel = UserModel(
            emailAddress: emailAddress,
            uid: credential.user!.uid,
            username: username,
            followers: [],
            following: [],
            profileImage:
                "https://www.seekpng.com/png/detail/966-9665493_my-profile-icon-blank-profile-image-circle.png",
                chattedUsers: [],
                savedPosts: []);
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email address is badly formatted';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInWithGoogle(BuildContext context) async {
    String res = 'some error occured';
    try {
      
      if (kIsWeb) {

        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          if (userCredential.user != null) {
            if (userCredential.additionalUserInfo!.isNewUser) {
              UserModel userModel = UserModel(
                  emailAddress: userCredential.user!.email!,
                  uid: userCredential.user!.uid,
                  username: userCredential.user!.displayName!,
                  followers: [],
                  following: [],
                  profileImage: userCredential.user!.photoURL!,
                  isPremium: false,
                  chattedUsers: [],
                  savedPosts: []);
              await _firestore
                  .collection('users')
                  .doc(userCredential.user!.uid)
                  .set(userModel.toJson());
            }
          }
        }
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
      // Displaying the error message
    }
    return res;
  }

  //signin user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  //change password
  Future<String> changePassword(
      {required String email}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        res = 'success';
      } else {
        res = 'please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  


}
