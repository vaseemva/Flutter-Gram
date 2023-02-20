import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/my_event_stream.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_tabbar.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/inperson_event_stream.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/online_event_stream.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          flexibleSpace: const EventTabBar(),
        ),
        body: const TabBarView(children: [
          OnlineEventStream(),
          InpersonEventStream(),
          MyEventsStream(),
        ]),
      ),
    );
  }
}
