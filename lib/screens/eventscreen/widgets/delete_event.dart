 import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';

Future<dynamic> deleteEvent(BuildContext context,String eventId) {
    return showDialog(
                            context: context,
                            builder: (context) => Dialog( 
                              
                              child: ListView(
                                padding: const EdgeInsets.symmetric(vertical: 16),  
                                shrinkWrap: true, 
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center, 
                                        crossAxisAlignment: CrossAxisAlignment.center ,
                                        children:const [
                                           Padding( 
                                             padding:  EdgeInsets.all(8.0),
                                             child: Text(
                                                'Are you sure you want to delete this event?'),
                                           ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                FirestoreMethods()
                                                    .deleteEventFromFirestore(
                                                        eventId);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                        ],
                                      )
                                    ],
                                  ),
                            ));
  }

