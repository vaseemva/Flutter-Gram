import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/strings.dart';

class NoArticles extends StatelessWidget {
  const NoArticles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Text(
         noArticles , 
          style:const TextStyle(
              fontSize: 15.0, 
             ),
        ),
      ),
    );
  }
}
