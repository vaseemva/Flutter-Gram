import 'package:flutter/cupertino.dart';

class PasswordProvider with ChangeNotifier{
 bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

}