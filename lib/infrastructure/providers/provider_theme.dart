import 'package:diary/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with  ChangeNotifier{
  ThemeData _themeData =  AppTheme(). lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == AppTheme().lightMode){
      themeData = AppTheme().darkMode;
    }else{
      themeData = AppTheme().lightMode;
    }
  }
  
 
}