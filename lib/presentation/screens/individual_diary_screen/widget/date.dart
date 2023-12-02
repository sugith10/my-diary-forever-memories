import 'package:diary/presentation/util/create_screen_functions.dart';
import 'package:diary/presentation/util/individual_diary_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DiaryDate extends StatelessWidget {
  final DateTime date;
  final String backgroundColor;
  const DiaryDate({super.key, required this.date, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Text(
         DateFormat('d MMMM,y').format(date),
        style: TextStyle(
          fontSize: 11.sp,
         color:CreateDiaryScreenFunctions().isColorBright(DiaryDetailPageFunctions().hexToColor(backgroundColor)) ? Colors.black : Colors.white ,
        ),
      ),
    );
  }
}