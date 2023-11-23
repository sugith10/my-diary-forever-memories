
import 'package:flutter/material.dart';

class DiaryScreenFunctions {
  
  Color _hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

  Color hexToColor(String code){
    return  _hexToColor(code);
  }
 
}
