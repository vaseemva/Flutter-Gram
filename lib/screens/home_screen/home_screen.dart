import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/add_screen/add_screen.dart';
import 'package:flutter_gram/screens/chat_screen/chat_screen.dart';
import 'package:flutter_gram/screens/eventscreen/event_screen.dart';
import 'package:flutter_gram/screens/feedscreen/feedscreen.dart';
import 'package:flutter_gram/screens/home_screen/widgets/customnavbar.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';
import 'package:flutter_gram/screens/search_screen/search_template.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [
    const Feedscreen(),
    const SearchTemplate(),
    const AddScreen(),
    const EventScreen(),
    const ChatScreen(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
  ];
  addData() async {
    final UserProvider userpro =
        Provider.of<UserProvider>(context, listen: false);
    userpro.refreshUser();
  }

  getname(User user) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user.uid).get();

    print(snapshot.data());

    currentUserName = (snapshot.data() as Map<String, dynamic>)["username"];
    currentUserEmail = (snapshot.data() as Map<String, dynamic>)["email"];
    currentUserUid = (snapshot.data() as Map<String, dynamic>)["uid"];
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = Provider.of<UserProvider>(context, listen: false);
        provider.refreshUser();
      });

      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        getname(user);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: pages[provider.selectedIndex],
      bottomNavigationBar: CustomNavBar(provider: provider),
    );
  }
}
