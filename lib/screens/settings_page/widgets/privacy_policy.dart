import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/strings.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(privacyPolicy),
            );
          },
        );
      },
      child: SettingsTile(
        title: tileTitle5,
        subtitle: tileSubTitle5,
        icon: Icons.privacy_tip_outlined,
      ),
    );
  }
}
