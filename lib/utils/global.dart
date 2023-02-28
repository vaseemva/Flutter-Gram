

import 'package:flutter/material.dart';

String? currentUserName;
String?currentUserEmail;
String? currentUserUid;

AppBar whiteAppBar(String title , {bool centerTitle = false}) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle, 
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      foregroundColor: Colors.black,
    );
  }
