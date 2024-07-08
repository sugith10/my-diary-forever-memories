import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/utils/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCard extends StatelessWidget {
  final Widget child;

  const ThemeCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: IsDark.check(context)
              ? AppDarkColor.instance.primaryText
              : AppLightColor.instance.primaryText,
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
