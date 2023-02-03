import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gram/providers/add_post_provider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/add_thumbnail_container.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/post_image_container.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/side_box.dart';
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
    final size = MediaQuery.of(context).size;
    //  UserModel user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(),
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
            Container(
                height: 60,
                decoration: const BoxDecoration(),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )),
            kHeight20,
            SideBox(size: size, title: 'Body'),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: TextFormField(
                controller: _bodyController,
                minLines: 13,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () => postArticle(
                      currentUserUid!,
                      provider.getFile,
                      currentUserName!,
                      "profileImage",
                      context,
                      _titleController.text,
                      _bodyController.text),
                  child: provider.isloading
                      ? const CircularProgressIndicator()
                      : const Text('Post')),
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
    provider.isLoading = true;

    if (provider.getFile != null &&
        _bodyController.text.isNotEmpty &&
        _titleController.text.isNotEmpty) {
      try {
        String res = await FirestoreMethods()
            .uploadPost(title, body, uid, thumbnail!, fullName, profileImage);

        if (res == 'success') {
          // ignore: use_build_context_synchronously
          showSnackBar('posted successfully', context);
          provider.isLoading = false;
          Navigator.of(context).pop();
        } else {
          // ignore: use_build_context_synchronously
          provider.isLoading = false;
          showSnackBar('Failed Posting', context);
        }
      } catch (e) {
        provider.isLoading = false;
        print(e.toString());
      }
    } else {
      showSnackBar('Please fill all the fields', context);
    }
  }
}
