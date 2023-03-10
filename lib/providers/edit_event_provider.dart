import 'dart:typed_data';

import 'package:flutter/material.dart';

class EditEventProvider with ChangeNotifier{
   Uint8List? _file;
  bool _isloading = false; 
  int _currentStep = 0;
  bool _isLaststep = false;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String _eventType = 'Online';
  String _loading='no';
  String get loading => _loading;

  bool _isImageChanged = false;

  bool get isImageChanged {
    return _isImageChanged;
  }

  set isImageChanged(bool isImageChanged) {
    _isImageChanged = isImageChanged;
    notifyListeners();
  }
  set loading(String loading) {
    _loading = loading;
    notifyListeners();
  }

  String get eventType => _eventType;
  set eventType(String eventType) {
    _eventType = eventType;
    notifyListeners();
  }

  TimeOfDay get timeOfDay => _timeOfDay;

  set timeOfDay(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
    notifyListeners();
  }

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  int get currentStep => _currentStep;
  set currentStep(int currentStep) {
    _currentStep = currentStep;
    notifyListeners();
  }

  bool get isLaststep => _isLaststep;
  set isLaststep(bool isLaststep) {
    _isLaststep = isLaststep;
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

  set changeIsLoading(bool isLoading) {
    _isloading = isloading;
    notifyListeners();
  }
}