import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
import 'package:flutter_gram/utils/strings.dart';

class SignOutTile extends StatelessWidget {
  const SignOutTile({
    super.key,
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to logout?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => SigninScreen(),
                      ));
                    },
                    child: const Text('Yes')),
              ],
            );
          },
        );
      },
      child: SettingsTile(
        title: tileTitle7,
        subtitle: tileSubTitle7,
        icon: Icons.logout_outlined,
      ),
    );
  }
}
