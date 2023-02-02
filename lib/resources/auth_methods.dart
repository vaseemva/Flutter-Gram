import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<UserModel>getUserDetails()async{
User currentUser=_auth.currentUser!;
DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
return UserModel.fromSnap(snap);
}

  //signing up user
  Future<String> signupUser(
      {required String fullName,
      required String emailAddress,
      required String password}) async {
    String res = 'some error occured';
    try {
      if (fullName.isNotEmpty &&
          password.isNotEmpty &&
          emailAddress.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: emailAddress, password: password);
        UserModel userModel = UserModel(
            emailAddress: emailAddress,
            uid: credential.user!.uid,
            fullName: fullName,
            followers: [],
            following: []);
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

  Future<void> signInWithGoogle(BuildContext context) async {
    
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

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
      // Displaying the error message
    }
  }


  //  signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn(
  //       scopes: <String>["email"]).signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

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
}
