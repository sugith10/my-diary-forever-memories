import 'package:flutter/material.dart';

class CreateDiaryScreenFunctions {
  

 

  bool _isColorBright(Color color) {
    return color.computeLuminance() > 0.4;
  }

  bool isColorBright(Color color) {
    return _isColorBright(color);
  }
}
