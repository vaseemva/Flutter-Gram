import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/add_post_provider.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/providers/password_provider.dart';
import 'package:flutter_gram/providers/signin_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/splash_screen/newsplash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDHSoG4Iw7kbp0Yx63ykhxUEsyXSVE0da8',
            appId: "1:62570990152:web:af815209d0d6953a4de67d",
            messagingSenderId: "62570990152",
            projectId: "flutter-gram-a1176",
            storageBucket: "flutter-gram-a1176.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SigninProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => AddPostProvider(),)
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.aBeeZeeTextTheme(),
            primarySwatch: Colors.blueGrey,
            useMaterial3: true
          ),
          home: const NewSplashScreen()),
    );
  }
}
