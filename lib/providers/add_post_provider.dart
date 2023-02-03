import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddPostProvider with ChangeNotifier {
  Uint8List? _file;
  bool _isloading = false;
  Uint8List? get getFile {
    if (_file == null) {
      return null;
    }
    return _file;
  }

  set setImage(Uint8List image) {
    _file = image;
    notifyListeners();
  }

  bool get isloading {
    return _isloading;
  }

  set isLoading(bool isLoading) {
    _isloading = isloading;
    notifyListeners();
  }
}
