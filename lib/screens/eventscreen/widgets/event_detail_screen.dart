import 'package:flutter/material.dart';
import 'package:flutter_gram/models/event.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_actions.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/event_detail_column.dart';
import 'package:flutter_gram/screens/eventscreen/widgets/pop_up_button.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key? key, required this.model}) : super(key: key);
  final EventModel model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
        appBar: AppBar(
          title: Text(model.title),
          actions: [
            model.uid == user.uid ? PopUpButton(model: model) : const SizedBox()
          ],
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              height: screenSize.height * 0.3,
              width: screenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              thickness: 3,
              endIndent: 16,
              indent: 18,
            ),
            EventDetailColumn(model: model),
            kHeight20,
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "About Event",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Text(model.description),
            ),
          ],
        ),
        bottomNavigationBar:
            EventActions(model: model, user: user, screenSize: screenSize));
  }
}
