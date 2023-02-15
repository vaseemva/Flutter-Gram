

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gram/screens/eventscreen/payment_box.dart';
import 'package:flutter_gram/utils/global.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream:FirebaseFirestore.instance.collection('users').doc(currentUserUid!).snapshots() ,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              if((snapshot.data as dynamic)['isPremium']){
                   return const Center(child: Text('You are a premium user'),);
              }
              return  PaymentBox();
            }));
  }
}
