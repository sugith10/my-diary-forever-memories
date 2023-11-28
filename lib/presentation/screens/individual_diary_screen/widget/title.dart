import 'package:diary/presentation/theme/primary_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DiaryTitle extends StatelessWidget {
  final String title;
  const DiaryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).brightness == Brightness.light 
            ? AppColor.dark.color
            : Colors.white,
      ),
      // overflow: TextOverflow.ellipsis,
    );
  }
}
