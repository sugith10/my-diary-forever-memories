import 'package:diary/view/theme/app_color.dart';
import 'package:flutter/material.dart';

class GetColors {
  //getThemeMode
  ThemeMode _getThemeMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  ThemeMode getThemeMode(BuildContext context) {
    return _getThemeMode(context);
  }

  //getThemeColor
  Color _getThemeColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.dark.color;
  }

  Color getThemeColor(BuildContext context) {
    return _getThemeColor(context);
  }

  //getThemeColorInString
  String  _getThemeColorString(BuildContext context) {
    Color selectedColor = Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.dark.color;

    return selectedColor.value.toRadixString(16).substring(2).toUpperCase();
  }

  String  getThemeColorString(BuildContext context){
      return  _getThemeColorString(context);
  } 

  //getAlertBoxColor
  Color _getAlertBoxColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.showMenuDark.color;
  }

  Color getAlertBoxColor(BuildContext context) {
    return _getAlertBoxColor(context);
  }


  //getFontColor
  Color _getFontColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.dark.color
        : AppColor.light.color;
  }

  Color getFontColor(BuildContext context) {
    return _getFontColor(context);
  }


  //getFontcolorReverse
  Color _getFontColorReverse(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.dark.color;
  }

  Color getFontColorReverse(BuildContext context) {
    return _getFontColorReverse(context);
  }
}
