import 'package:diary/presentation/util/create_screen_functions.dart';
import 'package:diary/presentation/util/individual_diary_screen_functions.dart';
import 'package:flutter/material.dart';

class DiaryContent extends StatelessWidget {
  final String content;
  final String backgroundColor;
  const DiaryContent(
      {super.key, required this.content, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: CreateDiaryScreenFunctions().isColorBright(
                DiaryDetailPageFunctions().hexToColor(backgroundColor))
            ? Colors.black
            : Colors.white,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
