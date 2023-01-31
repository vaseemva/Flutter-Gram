import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/add_screen/widgets/add_option.dart';
import 'package:flutter_gram/utils/constants.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AddOption(
              size: size,
              iconData: Icons.article,
              label: 'Add Article',
            ),
          ),
          kHeight20,
          Center(
            child: AddOption(
                size: size, label: 'Add Event', iconData: Icons.event),
          )
        ],
      ),
    );
  }
}
