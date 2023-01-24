import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_gram/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const OnboardingScreen(),
    );
  }
}
