import 'package:flutter/cupertino.dart';

class SigninProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set changeisLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
