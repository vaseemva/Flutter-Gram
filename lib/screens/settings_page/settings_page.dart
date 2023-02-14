import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
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
                child: const Text('clear')),
          ],
        ),
      ),
    );
  }
}
