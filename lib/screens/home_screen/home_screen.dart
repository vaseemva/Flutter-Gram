import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 HomeScreen({ Key? key }) : super(key: key);
final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            ElevatedButton(onPressed: () {
              _auth.signOut();
            }, child: Text('signout'))
          ],
        ),
      ),
    );
  }
}