import 'dart:typed_data';

import 'package:flutter/material.dart';

class EditPostProvider with ChangeNotifier {
  Uint8List? _file;
  bool _isloading = false;
  String _loading = 'No';
  bool _isImageChanged = false;

  bool get isImageChanged {
    return _isImageChanged;
  }

  set isImageChanged(bool isImageChanged) {
    _isImageChanged = isImageChanged;
    notifyListeners();
  }

  String get getLoading {
    return _loading;
  }

  set setLoading(String loading) {
    _loading = loading;
    notifyListeners();
  }

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

  resetimage() {
    _file = null;
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
