import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThemeSwitchCard extends StatelessWidget {
  final Widget child;

  const ThemeSwitchCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 15.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromRGBO(255, 255, 255, 1),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
