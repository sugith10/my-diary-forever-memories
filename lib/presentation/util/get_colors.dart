import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class GetColors {
  ThemeMode _getThemeMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;
}

  Color _getThemeColor(BuildContext context){
      return Theme.of(context).brightness == Brightness.light
      ? AppColor.light.color
      : AppColor.dark.color;
  }

  Color getThemeColor(BuildContext context){
      return _getThemeColor(context);
  }

   ThemeMode getThemeMode(BuildContext context) {
  return  _getThemeMode(context);
}

  Color _getAlertBoxColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.showMenuDark.color;
  }

  Color getAlertBoxColor(BuildContext context) {
    return _getAlertBoxColor(context);
  }

  Color _getFontColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.dark.color
        : AppColor.light.color;
  }

  Color getFontColor(BuildContext context) {
    return _getFontColor(context);
  }

  Color _getFontColorReverse(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.light.color
        : AppColor.dark.color;
  }

   Color getFontColorReverse(BuildContext context) {
    return _getFontColorReverse(context);
  }
}
