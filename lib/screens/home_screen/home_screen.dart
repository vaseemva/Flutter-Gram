import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
                onPressed: () {
                  _auth.signOut();
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
      ),
    );
  }
}
