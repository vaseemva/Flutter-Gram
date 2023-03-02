import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/add_post_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/add_thumbnail_container.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/body_text_field.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/post_image_container.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/side_box.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/title_text_field.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/global.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final acprovider = Provider.of<AddPostProvider>(context);
    final size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: whiteAppBar("Post an Article"),
      body: Consumer<AddPostProvider>(
        builder: (context, provider, child) => ListView(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            provider.getFile == null
                ? AddThumbnailContainer(size: size, provider: provider)
                : PostImageContainer(
                    size: size,
                    provider: provider,
                  ),
            kHeight20,
            SideBox(
              size: size,
              title: 'Title',
            ),
            TitleTextField(titleController: _titleController),
            kHeight20,
            SideBox(size: size, title: 'Body'),
            BodyTextField(bodyController: _bodyController),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: acprovider.getLoading == 'Yes'
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () => postArticle(
                          user.uid,
                          provider.getFile,
                          user.username,
                          user.profileImage,
                          context,
                          _titleController.text,
                          _bodyController.text),
                      child: const Text('Post')),
            )
          ],
        ),
      ),
    );
  }

  void postArticle(
      String uid,
      Uint8List? thumbnail,
      String fullName,
      String profileImage,
      BuildContext context,
      String title,
      String body) async {
    final provider = Provider.of<AddPostProvider>(context, listen: false);

    if (provider.getFile != null &&
        _bodyController.text.isNotEmpty &&
        _titleController.text.isNotEmpty) {
      try {
        provider.setLoading = 'Yes';
        String res = await FirestoreMethods()
            .uploadPost(title, body, uid, thumbnail!, fullName, profileImage);

        if (res == 'success') {
          provider.setLoading = 'No';
          // ignore: use_build_context_synchronously
          showSnackBar('posted successfully', context);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        } else {
          // ignore: use_build_context_synchronously
          provider.setLoading = 'No';
          // ignore: use_build_context_synchronously
          showSnackBar('Failed Posting', context);
        }
      } catch (e) {
        provider.setLoading = 'No';
      }
    } else {
      showSnackBar('Please fill all the field', context);
    }
  }
}
