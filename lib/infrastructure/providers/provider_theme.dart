import 'package:flutter/material.dart';

class ThemeNotifier extends  ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void switchLight(){
    if(_isDarkMode != false){
       _isDarkMode = false;
        notifyListeners();
    }
  }

  void switchDark(){
     if(_isDarkMode != true){
     _isDarkMode = true;
      notifyListeners();
    }
   
  }

}
