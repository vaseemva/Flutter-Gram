import 'package:flutter/material.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/edit_post_screen/edit_post_screen.dart';

class PopUpForArticle extends StatelessWidget {
  const PopUpForArticle({
    super.key,
    required this.snap,
  });

  final  snap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: (value) {
          // handle the selected option
          switch (value) {
            case 'option1':
              // do something for option 1
              deletePost(context);
              break;
            case 'option2':
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => EditPostScreen(
                  snap: snap,
                ),
              ));
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'option1',
            child: Text('Delete Post'),
          ),
          const PopupMenuItem(
            value: 'option2',
            child: Text('Edit Post'),
          ),
        ],
      );
  }
    Future<dynamic> deletePost(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Are you sure you want to delete this event?'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FirestoreMethods().deletePost(snap['postId']);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
          ],
        ),
      ),
    );
  }
}



