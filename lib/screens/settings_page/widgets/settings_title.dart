import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children:const [
        SizedBox(width: 10,),
         Text('Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            Spacer(),
            Icon(Icons.settings),
            SizedBox(width: 25,),
      ],
    );
  }
}

