import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/home_screen/home_screen.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
import 'package:flutter_gram/screens/splash_screen/splash_screen.dart';

class NewSplashScreen extends StatelessWidget {
  const NewSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _handleAuthState(context);
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}

Widget _handleAuthState(BuildContext context) {
  return StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      // if (!snapshot.hasData) return const SplashScreen();
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else if (snapshot.hasError) {
          Center(
            child: Text('${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
      }
      return SigninScreen();
    },
  );
}
