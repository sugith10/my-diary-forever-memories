import 'dart:io';
import 'package:diary/core/data/model/hive/hive_database_model/archive_db_model/archive_db_model.dart';
import 'package:diary/core/presentation/pages/pages/individual_diary_page/widget/content.dart';
import 'package:diary/core/presentation/pages/pages/individual_diary_page/widget/date.dart';
import 'package:diary/core/presentation/pages/pages/individual_diary_page/widget/title.dart';
import 'package:diary/core/presentation/pages/pages/widget/back_button.dart';
import 'package:diary/core/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/core/presentation/pages/util/archive_page_functions.dart';
import 'package:diary/core/presentation/pages/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class IndividualArchive extends StatelessWidget {
  final ArchiveDiary archiveDiary;
  const IndividualArchive({required this.archiveDiary, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: const BottomBorderWidget(),
        leading: const BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: () {
              ArchivePageUtil().showingMenu(context, archiveDiary);
            },
            icon: const Icon(
              Ionicons.ellipsis_vertical_outline,
            ),
          )
        ],
      ),
      body: Container(
        color: DiaryDetailPageFunctions().hexToColor(archiveDiary.background, context),
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
