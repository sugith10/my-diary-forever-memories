import 'dart:io';


import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../data/model/hive/archive_db_model/archive_db_model.dart';
import '../../util/archive_page_functions.dart';
import '../../util/individual_diary_page_util.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../individual_diary_page/widget/content.dart';
import '../../../feature/diary/view/widget/date.dart';
import '../individual_diary_page/widget/title.dart';


class IndividualArchive extends StatelessWidget {
  final ArchiveDiary archiveDiary;
  const IndividualArchive({required this.archiveDiary, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(children: [ IconButton(
            onPressed: () {
              ArchivePageUtil().showingMenu(context, archiveDiary);
            },
            icon: const Icon(IconlyLight.category),
          )],),
      body: Container(
        color: ViewDiaryPageFunctions().hexToColor(archiveDiary.background, context),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DiaryDate(
                date: archiveDiary.date,
                backgroundColor: archiveDiary.background,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DiaryTitle(
                      title: archiveDiary.title,
                      backgroundColor: archiveDiary.background,
                    ),
                  ),
                ],
              ),
            ),
            if (archiveDiary.imagePath != null)
              GestureDetector(
                onTap: () {
                  ArchivePageUtil().showOriginalImage(context, archiveDiary);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(archiveDiary.imagePath!),
                      fit: BoxFit.cover,
                      height: 380,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DiaryContent(
                content: archiveDiary.content,
                backgroundColor: archiveDiary.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
