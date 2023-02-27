import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/about_us.dart';
import 'package:flutter_gram/screens/settings_page/widgets/buy_premium.dart';
import 'package:flutter_gram/screens/settings_page/widgets/change_password.dart';
import 'package:flutter_gram/screens/settings_page/widgets/privacy_policy.dart';
import 'package:flutter_gram/screens/settings_page/widgets/send_feedback.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_subtitle.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_title.dart';
import 'package:flutter_gram/screens/settings_page/widgets/signout_tile.dart';
import 'package:flutter_gram/utils/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key, required this.isPremium}) : super(key: key);
  final bool isPremium;

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
               const ChangePassword(),
                BuyPremium(isPremium: isPremium)
              ],
            ),
          ),
          SettingSubTitle(title: settingsTitle2),
          const SendFeedBack(),
          const PrivacyPolicy(),
          const AboutUs(),
          SignOutTile(auth: auth),
        ],
      ),
    );
  }
}

