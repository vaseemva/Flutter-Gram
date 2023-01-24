import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/widgets/intro_widget.dart';
import 'package:flutter_gram/utils/strings.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: IntroWidget(
          size: size,
          image: intro3Image,
          subtitle: intro3SubTitle,
          title: intro3Title,
          leftPosition: 65),
    );
  }
}
