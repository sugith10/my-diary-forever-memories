import 'package:flutter/material.dart';

import '../../utils/is_dark.dart';
import '../theme/app_color/app_colors.dart';

class AppPickerTheme extends StatelessWidget {
  final Widget? child;
  const AppPickerTheme({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: IsDark.check(context)
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppDarkColor.instance.primaryText,
                secondary: AppDarkColor.instance.secondaryText,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppLightColor.instance.primaryText,
                secondary: AppLightColor.instance.secondaryText,
              ),
            ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
