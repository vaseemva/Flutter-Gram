import 'package:flutter/material.dart';

class FieldProvider with ChangeNotifier{
  String _comment = "";
  String get comment => _comment;
  set comment(String value){
    _comment = value;
    notifyListeners();
  }
  refreshCommenttextfield(){
    _comment = "";
    notifyListeners();
  }
  
}