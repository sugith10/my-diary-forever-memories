import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';

class GetColors {
  Color _getAlertBoxColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColor.showMenuLight.color
        : AppColor.showMenuDark.color;
  }

    Color getAlertBoxColor(BuildContext context) {
    return getAlertBoxColor(context);
  }

  
}
