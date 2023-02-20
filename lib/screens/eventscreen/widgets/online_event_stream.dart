import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_card.dart';

class OnlineEventStream extends StatelessWidget {
const OnlineEventStream({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return StreamBuilder(stream: FirestoreMethods().getEventsStreamByType('Online'),builder: (context, snapshot) {
      if(!snapshot.hasData){
        return const Center(child: CircularProgressIndicator(),);
      }
      if(snapshot.data!.isEmpty){
        return const Center(child: Text('No Online Events'),);
      }
      return Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.only(top: 5,right: 20.0, left: 20.0), 
          child: ListView.builder(
            itemBuilder: (context, index) {
              return EventCard(model: snapshot.data![index],);
            },
            itemCount: snapshot.data!.length,
          ),
        ),
      );
      
    },);
  }
}