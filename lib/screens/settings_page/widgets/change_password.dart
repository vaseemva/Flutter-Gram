import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/auth_methods.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ListView(
                shrinkWrap: true,
                children: [
                  const Text('Are you sure?'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            String res = await AuthMethods()
                                .changePassword(email: userModel.emailAddress);
                            if (res == 'success') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Password reset link sent to your email'),
                              ));
                            }
                          },
                          child: const Text('Yes'))
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: SettingsTile(
        title: tileTitle2,
        subtitle: tileSubTitle2,
        icon: Icons.lock,
      ),
    );
  }
}
