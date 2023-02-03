
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/post_card.dart';


class Feedscreen extends StatelessWidget {
const Feedscreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      body: Center(child: PostCard(),)
    );
  }
}