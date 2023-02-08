import 'package:flutter/material.dart';

class ArticlesText extends StatelessWidget {
  const ArticlesText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(padding:EdgeInsets.only(left: 15,bottom: 8,),child: 
    Text("Articles",style: TextStyle(fontWeight: FontWeight.bold),),);
  }
}