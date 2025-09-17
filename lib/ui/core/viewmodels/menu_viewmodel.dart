import 'package:flutter/material.dart';

class MenuViewmodel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
