import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../model/archive_diary_model/archive_diary_model.dart';
import '../../../../core/util/util/archive_page_functions.dart';
import '../../../../core/util/util/individual_diary_page_util.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../diary/view/widget/content.dart';
import '../../../diary/view/widget/date.dart';
import '../../../diary/view/widget/title.dart';


class IndividualArchive extends StatelessWidget {
  final ArchiveDiaryModel archiveDiaryModel;
  const IndividualArchive({required this.archiveDiaryModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(children: [ IconButton(
            onPressed: () {
              ArchivePageUtil().showingMenu(context, archiveDiaryModel);
            },
            icon: const Icon(IconlyLight.category),
          )],),
      body: Container(
        color: ViewDiaryPageFunctions().hexToColor(archiveDiaryModel.background, context),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DiaryDate(
                date: archiveDiaryModel.date,
                backgroundColor: archiveDiaryModel.background,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DiaryTitle(
                      title: archiveDiaryModel.title,
                      backgroundColor: archiveDiaryModel.background,
                    ),
                  ),
                ],
              ),
            ),
            if (archiveDiaryModel.imagePath != null)
              GestureDetector(
                onTap: () {
                  ArchivePageUtil().showOriginalImage(context, archiveDiaryModel);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(archiveDiaryModel.imagePath!),
                      fit: BoxFit.cover,
                      height: 380,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DiaryContent(
                content: archiveDiaryModel.content,
                backgroundColor: archiveDiaryModel.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
