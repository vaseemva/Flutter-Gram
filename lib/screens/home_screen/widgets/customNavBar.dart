import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final BottomNavProvider provider;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: bottomnavSelectedcolor,
        unselectedItemColor: bottomNavUnselectedcolor,
        iconSize: 30,
        currentIndex: provider.selectedIndex,
        onTap: (value) {
          provider.changeIndex = value;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ]);
  }
}
