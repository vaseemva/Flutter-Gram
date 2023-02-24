import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_title.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          const SettingsTitle(),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          SettingSubTitle(
            title: settingsTitle1,
          ),
          SizedBox(
            child: Column(
              children: [
                SettingsTile(
                  title: tileTitle1,
                  subtitle: tileSubTitle1,
                  icon: Icons.person,
                ),
                SettingsTile(
                    title: tileTitle2,
                    subtitle: tileSubTitle2,
                    icon: Icons.lock),
                SettingsTile(
                    title: tileTitle3,
                    subtitle: tileSubTitle3,
                    icon: Icons.workspace_premium)
              ],
            ),
          ),
          SettingSubTitle(title: settingsTitle2),
          SettingsTile(
              title: tileTitle4,
              subtitle: tileSubTitle4,
              icon: Icons.mail_outline),
          SettingsTile(
              title: tileTitle5,
              subtitle: tileSubTitle5,
              icon: Icons.privacy_tip_outlined),
          SettingsTile(
              title: tileTitle6,
              subtitle: tileSubTitle6,
              icon: Icons.help_outline),
          SettingsTile(
              title: tileTitle7,
              subtitle: tileSubTitle7,
              icon: Icons.logout_outlined),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.function,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final void function;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function;
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: settingsTitleColor,
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}

class SettingSubTitle extends StatelessWidget {
  const SettingSubTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
