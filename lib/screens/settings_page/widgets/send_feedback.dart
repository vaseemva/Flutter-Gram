import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:flutter_gram/utils/utils.dart';

class SendFeedBack extends StatelessWidget {
  const SendFeedBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sendMail(ownerEmail);
      },
      child: SettingsTile(
        title: tileTitle4,
        subtitle: tileSubTitle4,
        icon: Icons.mail_outline,
      ),
    );
  }
}