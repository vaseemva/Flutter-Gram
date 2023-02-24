import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({
    super.key,
    required this.snap,
  });

  final DocumentSnapshot<Object?> snap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          snap['username'],
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        snap['isPremium']
      ? const Icon(
          Icons.verified,
          color: Colors.blue,
        )
      :const SizedBox(), 
      ],
    );
  }
}
