import 'package:flutter/material.dart';

class EventTabBar extends StatelessWidget {
  const EventTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(tabs: [
      Tab(
        child: Text(
          'Online',
        ),
      ),
      Tab(
        child: Text(
          'In Person',
        ),
      ),
      Tab(
        child: Text(
          'My Events',
        ),
      ),
    ]);
  }
}
