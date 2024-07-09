import 'package:diary/view/util/create_screen_functions.dart';
import 'package:diary/view/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


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
          fontSize: 11.sh,
         color:CreateDiaryScreenFunctions().isColorBright(ViewDiaryPageFunctions().hexToColor(backgroundColor,context)) 
         ? Colors.black : Colors.white ,
        ),
      ),
    );
  }
}