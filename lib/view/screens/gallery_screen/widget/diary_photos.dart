import 'dart:io';
import 'package:diary/features/my_diary/diary_entry_db_model/diary_entry.dart';
import 'package:diary/view/util/screen_transitions/bottom_to_top.dart';
import 'package:diary/view/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class DiaryPhotos extends StatelessWidget {
  final String imagePath;

  const DiaryPhotos({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final diaryEntry = Hive.box<DiaryEntry>('diaryEntryBox').values.firstWhere(
          (entry) => entry.imagePath == imagePath,
        );

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, bottomToTop(DiaryDetailPage(entry: diaryEntry)));
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
