import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThemeSwitchCard extends StatelessWidget {
  final Widget child;

  const ThemeSwitchCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 15.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          // color: Colors.grey.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
