import 'package:flutter/material.dart';

class FieldProvider with ChangeNotifier{
 bool _isShowUsers = false;
 bool get getIsShowUsers => _isShowUsers;
 set setIsShowUsers(bool isShowUsers){
   _isShowUsers = isShowUsers;
   notifyListeners();
 }
  
}