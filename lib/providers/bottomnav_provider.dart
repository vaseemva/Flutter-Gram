import 'package:flutter/cupertino.dart';

class BottomNavProvider with ChangeNotifier{
  int _selectedIndex=0;
  int get selectedIndex{
    return _selectedIndex;
    
  }
 set changeIndex(int index){
  _selectedIndex=index;
  notifyListeners();
 }

}