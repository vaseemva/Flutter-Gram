import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/name_and_date.dart';
import 'package:flutter_gram/screens/feedscreen/widgets.dart/thumbnail_widget.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';


class ArticleScreeen extends StatelessWidget {
  const ArticleScreeen({Key? key, this.snap}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        //create a row of username and profile image and date published
        Row(
          children: [
            SizedBox(
              width: size.width * 0.03,
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://th.bing.com/th/id/OIP.GlIuUj-GYrRL_G8WvZ3YagHaHw?w=189&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            NameandDate(snap: snap)
          ],
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.09,
              ),
              IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        snap['postId'], currentUserUid!, snap['likes']);
                  },
                  icon: snap['likes'].contains(currentUserUid)
                      ? const Icon(Icons.arrow_circle_down)
                      : const Icon(Icons.arrow_circle_up)),
              Text('${snap['likes'].length}'),
              kwidth15,
              const Icon(Icons.comment_outlined),
              const Text('125'),
              kwidth15,
              const Icon(Icons.share_outlined),
              kwidth15,
              const Icon(Icons.bookmark_border)
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            snap['title'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        ThumbnailWidget(size: size, snap: snap),
        SizedBox(
          height: size.height * 0.03,
        ),
        BodyText(snap: snap),
      ],
    ));
  }
}

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.snap,
  });

  final snap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Text(
        snap['body'],
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
