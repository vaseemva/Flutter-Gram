import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/providers/edit_post_provider.dart';
import 'package:flutter_gram/providers/userprovider.dart';
import 'package:flutter_gram/resources/firestore_methods.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/body_text_field.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/side_box.dart';
import 'package:flutter_gram/screens/add_post_screen/widgets/title_text_field.dart';
import 'package:flutter_gram/screens/edit_post_screen/widgets/edit_image_container.dart';

import 'package:flutter_gram/screens/edit_post_screen/widgets/edit_thumbnail_container.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/utils.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key, required this.snap}) : super(key: key);
  final snap;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
    _titleController.text = widget.snap['title'];
    _bodyController.text = widget.snap['body'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).getUser;

    return WillPopScope(
      onWillPop: () {
        final provider = Provider.of<EditPostProvider>(context, listen: false);
        provider.isImageChanged = false;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit  Article"),
        ),
        body: Consumer<EditPostProvider>(
          builder: (context, provider, child) => ListView(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              // provider.getFile == null
              //     ?
              provider.isImageChanged
                  ? EditImageContainer(
                      size: size,
                      provider: provider,
                    )
                  : EditThumbnailContainer(
                      size: size,
                      provider: provider,
                      imageUrl: widget.snap['postUrl'],
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
                child: provider.getLoading == 'Yes'
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => provider.isImageChanged
                            ? editwithImage(
                                user.uid,
                                provider.getFile!,
                                user.username,
                                user.profileImage,
                                context,
                                widget.snap['postId'],
                                _titleController.text,
                                _bodyController.text)
                            : editArticle(
                                user.uid,
                                widget.snap['postUrl'],
                                user.username,
                                user.profileImage,
                                context,
                                widget.snap['postId'],
                                _titleController.text,
                                _bodyController.text),
                        child: const Text('Edit Article')),
              )
            ],
          ),
        ),
      ),
    );
  }

  void editArticle(
    String uid,
    String photoUrl,
    String fullName,
    String profileImage,
    BuildContext context,
    String postId,
    String title,
    String body,
  ) async {
    final provider = Provider.of<EditPostProvider>(context, listen: false);

    if (_bodyController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      try {
        provider.setLoading = 'Yes';
        String res = await FirestoreMethods().editPost(
            title, body, uid, photoUrl, fullName, profileImage, postId);

        if (res == 'success') {
          provider.setLoading = 'No';
          // ignore: use_build_context_synchronously
          showSnackBar('Updated successfully', context);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        } else {
          // ignore: use_build_context_synchronously
          provider.setLoading = 'No';
          // ignore: use_build_context_synchronously
          showSnackBar('Failed Updating', context);
        }
      } catch (e) {
        provider.setLoading = 'No';
        print(e.toString());
      }
    } else {
      showSnackBar('Please fill all the field', context);
    }
  }

  void editwithImage(
    String uid,
    Uint8List file,
    String fullName,
    String profileImage,
    BuildContext context,
    String postId,
    String title,
    String body,
  ) async {
    final provider = Provider.of<EditPostProvider>(context, listen: false);
    if (_bodyController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      try {
        provider.setLoading = 'Yes';

        String res = await FirestoreMethods().editPostWithImage(
            title, body, uid, file, fullName, profileImage, postId);
        if (res == 'success') {
          provider.setLoading = 'No';
          // ignore: use_build_context_synchronously
          showSnackBar('Updated successfully', context);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          provider.isImageChanged = false;
        } else {
          provider.setLoading = 'No';
          provider.isImageChanged = false;
        }
      } catch (e) {
        print(e.toString());
        provider.setLoading = 'No';
        provider.isImageChanged = false;
      }
    } else {
      showSnackBar('Please fill all the field', context);
    }
  }
}
