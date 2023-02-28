import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/edit_profile_provider.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({
    super.key,
    required this.screenSize,
    required this.user,
    required this.provider,
  });

  final Size screenSize;
  final UserModel user;
  final EditProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Name  : ',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        SizedBox(
          width: screenSize.width * 0.7,
          height: screenSize.height * 0.05,
          child: TextFormField(
            initialValue: user.username,
            decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8)),
            onChanged: (value) {
              provider.isNameBioUpdated = true;
              provider.setName = value;
            },
          ),
        ),
      ],
    );
  }
}
