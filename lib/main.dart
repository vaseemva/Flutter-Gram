import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/password_provider.dart';
// import 'package:flutter_gram/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
// import 'package:flutter_gram/screens/splash_screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PasswordProvider(),) 
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home:  SigninScreen(),  
      ),
    );
  }
}
