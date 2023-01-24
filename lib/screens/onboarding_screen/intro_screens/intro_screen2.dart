import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/widgets/intro_widget.dart';
import 'package:flutter_gram/utils/strings.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: IntroWidget(
        size: size,
        image: intro2Image,
        subtitle: intro2SubTitle,
        title: intro2Title,
        radius: const BorderRadius.only(
          bottomRight: Radius.circular(180),
        ),
        leftPosition: 20,
      ),
    );
  }
}
