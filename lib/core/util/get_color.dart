import 'package:flutter/material.dart';

class GetColor {
  GetColor._();

  static String colorToString(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static Color stringToColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int value = int.parse(colorString, radix: 16);
    return Color(value);
  }
}
