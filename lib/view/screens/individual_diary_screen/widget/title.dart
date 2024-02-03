import 'package:diary/view/util/create_screen_functions.dart';
import 'package:diary/view/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DiaryTitle extends StatelessWidget {
  final String title;
  final String backgroundColor;
  const DiaryTitle({super.key, required this.title,required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color:CreateDiaryScreenFunctions().isColorBright(DiaryDetailPageFunctions().hexToColor(backgroundColor, context)) ? Colors.black : Colors.white ,
      ),
      // overflow: TextOverflow.ellipsis,
    );
  }
}
