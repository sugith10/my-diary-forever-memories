import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/core/util/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCard extends StatelessWidget {
  final VoidCallback onTap;
  final int value;
  final int groupValue;
  final Color activeColor;
  final Color themeColor;
  final String title;
  const ThemeCard({
    super.key,
    required this.title,
    required this.activeColor,
    required this.onTap,
    required this.groupValue,
   required this.value,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        HapticFeedback.mediumImpact();
      },
      child: _ThemeCard(
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Radio(
              value: value,
              activeColor: activeColor,
              groupValue: groupValue,
              onChanged: (_) {
                onTap();
                HapticFeedback.mediumImpact();
              },
            ),
            const SizedBox(width: 20),
            _ThemeCardBody(
              text: title,
              color: themeColor,
            ),
          ],
        ),
      ),
    );
  }
}


class _ThemeCard extends StatelessWidget {
  final Widget child;

  const _ThemeCard({required this.child});

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

class _ThemeCardBody extends StatelessWidget {
  final String text;
  final Color color;

  const _ThemeCardBody({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3)
                          : const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4))
                ]),
            height: 60,
            width: 210,
          ),
        ),
      ],
    );
  }
}
