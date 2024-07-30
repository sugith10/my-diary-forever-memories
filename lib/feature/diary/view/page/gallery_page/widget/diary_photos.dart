import 'dart:io';
import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../individual_diary_page.dart';


class DiaryPhotos extends StatelessWidget {
  final String imagePath;

  const DiaryPhotos({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final diaryModel = Hive.box<DiaryModel>('DiaryModelBox').values.firstWhere(
          (entry) => entry.imagePath == imagePath,
        );

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, bottomToTop(ViewDiaryPage(entry: diaryModel)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
