import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppbarTitleWidget extends StatelessWidget {
  final String text;

  const AppbarTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'SFPRO',
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
