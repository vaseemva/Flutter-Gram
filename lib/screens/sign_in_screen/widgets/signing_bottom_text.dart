import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/constants.dart';

class SigningBottomText extends StatelessWidget {
  const SigningBottomText({
    Key? key, required this.onTap, required this.longText, required this.buttonText,
  }) : super(key: key);
  final Function onTap;
  final String longText;
  final String buttonText;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth15,
       Text(longText),
        kwidth5,
        GestureDetector(
          onTap: onTap(),
          child: Text(
            buttonText,
            style:const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

