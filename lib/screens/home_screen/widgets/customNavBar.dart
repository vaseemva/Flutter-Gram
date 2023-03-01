import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/screens/home_screen/widgets/navbar_icon.dart';
import 'package:flutter_gram/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final BottomNavProvider provider;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: bottomnavbackgroundColor,
        buttonBackgroundColor: bottombuttonBackgroundColor,
        height: 60,
        index: provider.selectedIndex,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (value) {
          provider.changeIndex = value;
        },
        items: [
          BottomNavIcon(icon: Icons.home, index: 0, provider: provider),
          BottomNavIcon(icon: Icons.search, index: 1, provider: provider),
          BottomNavIcon(
              icon: Icons.add_box_outlined, index: 2, provider: provider),
          BottomNavIcon(icon: Icons.event, index: 3, provider: provider),
          BottomNavIcon(icon: Icons.chat, index: 4, provider: provider),
          BottomNavIcon(icon: Icons.person, index: 5, provider: provider),
        ]);
  }
}
