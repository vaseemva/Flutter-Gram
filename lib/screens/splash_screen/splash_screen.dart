import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/onboarding_screen/onboarding_screen.dart';

import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToOnBoarding() async {
    await Future.delayed(const Duration(seconds: 1));
    final preferences=await SharedPreferences.getInstance();
    bool introWatch=preferences.getBool('introWatched')??false;
    // ignore: use_build_context_synchronously
    if(introWatch==false){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ));
    }
  }

  @override
  void initState() {
    navigateToOnBoarding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kHeight100,
          SizedBox(
              width: size.width * 0.50,
              height: size.height * 0.20,
              child: Image.asset(
                'assets/images/app_logo.png',
              )),
          Text(
            appTitle,
            style: GoogleFonts.acme(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          kHeight10,
          Text(appTagline, style: GoogleFonts.aBeeZee()),
          SizedBox(
            height: size.height * 0.25,
          ),
          Text(appSlogan, style: GoogleFonts.aBeeZee())
        ],
      )),
    );
  }
}
