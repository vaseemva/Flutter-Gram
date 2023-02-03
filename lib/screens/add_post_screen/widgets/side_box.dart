import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/constants.dart';

class SideBox extends StatelessWidget {
  const SideBox({
    super.key,
    required this.size, required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: size.width*0.067,),   
        Container(
          height: size.height * 0.03,
          width: size.width * 0.02,
          color: sideBoxColor,
        ),
        kwidth5,
       Text(title,style:const TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),)
      ],
    );
  }
}
