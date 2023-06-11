import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  dynamic _data;

  dynamic get data => _data;

  void setData(dynamic newData) {
    _data = newData;
    notifyListeners();
  }
}
