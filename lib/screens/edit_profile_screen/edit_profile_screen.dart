import 'package:flutter/material.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/edit_profile_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/screens/edit_profile_screen/widgets/change_bio.dart';
import 'package:flutter_gram/screens/edit_profile_screen/widgets/change_name.dart';
import 'package:flutter_gram/screens/edit_profile_screen/widgets/select_image_container.dart';
import 'package:flutter_gram/screens/edit_profile_screen/widgets/update_button.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      final editprovider =
          Provider.of<EditProfileProvider>(context, listen: false);
      editprovider.setName = provider.getUser.username;
      editprovider.setBio = provider.getUser.bio;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    final provider = Provider.of<EditProfileProvider>(context);

    return WillPopScope(
      onWillPop: () {
        provider.isImageChanged = false;
        provider.resetimage();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: whiteAppBar("Edit Profile", centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectImageContainer(
                  provider: provider, user: user, screenSize: screenSize),
              kHeight20,
              ChangeName(
                  screenSize: screenSize, user: user, provider: provider),
              kHeight20,
              ChangeBio(screenSize: screenSize, user: user, provider: provider),
              kHeight20,
              UpdateButton(
                screenSize: screenSize,
                provider: provider,
                uid: user.uid,
              )
            ],
          ),
        ),
      ),
    );
  }
}
