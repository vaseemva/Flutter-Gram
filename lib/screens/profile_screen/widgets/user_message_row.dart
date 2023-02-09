import 'package:flutter/material.dart';

class UserMessageRow extends StatelessWidget {
  const UserMessageRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mail,
              size: 30,
              color: Colors.blueGrey,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message,
              size: 30,
              color: Colors.blueGrey,
            )),
            ElevatedButton.icon(onPressed: () {
              
            }, icon:const Icon( Icons.person_add), label:const Text('Follow'))
      ],
    );
  }
}
