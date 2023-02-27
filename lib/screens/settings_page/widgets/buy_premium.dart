import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/eventscreen/payment_box.dart';
import 'package:flutter_gram/screens/settings_page/widgets/settings_tile.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:flutter_gram/utils/strings.dart';

class BuyPremium extends StatelessWidget {
  const BuyPremium({
    super.key,
    required this.isPremium,
  });

  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserUid!)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: SizedBox());
          }
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return (snapshot.data as dynamic)['isPremium']
                      ? const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                              child: Text('You are already a premium user')),
                        )
                      : PaymentBox();
                },
              );
            },
            child: SettingsTile(
              title: tileTitle3,
              subtitle: tileSubTitle3,
              icon: Icons.workspace_premium,
            ),
          );
        });
  }
}
