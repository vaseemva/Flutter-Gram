import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatelessWidget {
const EventScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final FirebaseAuth auth = FirebaseAuth.instance;
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
                onPressed: () {
                  auth.signOut();
                },
                child: const Text('signout')),
            ElevatedButton(
                onPressed: () async {
                  final preferences = await SharedPreferences.getInstance();
                  preferences.clear();
                },
                child: const Text('clear'))
          ],
        ),
      );
  }
}