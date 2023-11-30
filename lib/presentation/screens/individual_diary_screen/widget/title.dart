import 'package:diary/presentation/util/create_page_screen_functions.dart';
import 'package:diary/presentation/util/individual_diary_screen_functions.dart';
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
        color:CreateDiaryScreenFunctions().isColorBright(DiaryDetailPageFunctions().hexToColor(backgroundColor)) ? Colors.black : Colors.white ,
      ),
      // overflow: TextOverflow.ellipsis,
    );
  }
}
