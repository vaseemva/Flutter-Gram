import 'package:flutter/cupertino.dart';
import 'package:flutter_gram/models/user.dart';
import 'package:flutter_gram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();
  UserModel get getUser {
    // //  refreshUser();
    // // return _user!;
    // if (_user == null) {
    //   // handle the case where the user is null
    //   refreshUser();
    // }
    return _user!;
  }
  set setUser(UserModel userModel){
    _user=userModel;
  }

  UserProvider() {
    refreshUser();
  }

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
