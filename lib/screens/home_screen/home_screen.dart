import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/screens/add_screen/add_screen.dart';
import 'package:flutter_gram/screens/eventscreen/event_screen.dart';
import 'package:flutter_gram/screens/feedscreen/feedscreen.dart';
import 'package:flutter_gram/screens/home_screen/widgets/customNavBar.dart';
import 'package:flutter_gram/screens/profile_screen/profile_screen.dart';
import 'package:flutter_gram/screens/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final pages = [
    const Feedscreen(),
    const SearchScreen(),
    const AddScreen(),
    const EventScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: pages[provider.selectedIndex],
      bottomNavigationBar: CustomNavBar(provider: provider),
    );
  }
}

