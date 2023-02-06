import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
const CommentScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: const Center(
        child: Text("Comments"),
      ),
    );
  }
}