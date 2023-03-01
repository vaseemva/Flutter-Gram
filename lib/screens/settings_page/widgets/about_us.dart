import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({
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
              child: Column(
                children: [
                  const Text(
                    "About Us",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  kHeight10,
                  Text(aboutMeDescription),
                ],
              ),
            );
          },
        );
      },
      child: SettingsTile(
        title: tileTitle6,
        subtitle: tileSubTitle6,
        icon: Icons.help_outline,
      ),
    );
  }
}
