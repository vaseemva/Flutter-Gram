import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/widgets/intro_widget.dart';
import 'package:flutter_gram/utils/strings.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: IntroWidget(
        size: size,
        image: intro1Image,
        title: intro1Title,
        subtitle: intro1SubTitle,
        leftPosition: 65,
      ),
    );
  }
}
