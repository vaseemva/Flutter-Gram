import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/strings.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        ));
      },
      child: SettingsTile(
        title: tileTitle1,
        subtitle: tileSubTitle1,
        icon: Icons.person,
      ),
    );
  }
}
