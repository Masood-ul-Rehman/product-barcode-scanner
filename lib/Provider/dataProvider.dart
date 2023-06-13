import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  dynamic _data;
  dynamic _store;
  dynamic _storeName;
  dynamic get data => _data;
  dynamic get store => _store;
  dynamic get storeName => _storeName;

  void setData(dynamic newData) {
    _data = newData;
    notifyListeners();
  }

  void setStore(dynamic id) {
    _store = id;
    notifyListeners();
  }

  void setStoreName(dynamic name) {
    _storeName = name;
    notifyListeners();
  }
}
