import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': fullName,
          'uid': credential.user!.uid,
          'email': emailAddress,
          'followers': [],
          'following': []
        });
        res = 'success';
      }
    }on FirebaseAuthException catch(err){
     if(err.code=='invalid-email'){
      res='The email address is badly formatted';
     }
    } 
    catch (e) {
      res = e.toString();
    }
    return res;
  }
}