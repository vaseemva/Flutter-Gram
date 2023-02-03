
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/add_post_screen/add_post_screen.dart';
import 'package:flutter_gram/screens/add_screen/widgets/add_post.dart';


class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AddPost(
              size: size,
              iconData: Icons.article,
              label: 'Add Article',
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: AddPost(
              size: size,
              label: 'Add Event',
              iconData: Icons.event,
            ),
          )
        ],
      ),
    );
  }

  // void _toAddPost(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => AddPostScreen(),
  //   ));
  // }
}
