import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/models/message.dart';
import 'package:flutter_gram/resources/chat_methods.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
                  // final preferences = await SharedPreferences.getInstance();
                  // preferences.clear();
                  ChatMethods().sendMessage('4zoQ05CLKqZrTEwVGvdY3EUiBqD2',currentUserUid!, 
                       'new message'); 
                },
                child: const Text('clear')),
          ],
        ),
      ),
    );
  }
}
