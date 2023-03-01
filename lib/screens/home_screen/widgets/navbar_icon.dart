import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/bottomnav_provider.dart';
import 'package:flutter_gram/utils/colors.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.icon,
    required this.index,
    required this.provider,
  });
  final IconData icon;
  final int index;
  final BottomNavProvider provider;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: provider.selectedIndex == index
          ? bottomNavSelectedColor
          : bottomNavUnselectedColor,
    );
  }
}
