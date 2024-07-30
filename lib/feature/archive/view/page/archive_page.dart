import 'package:diary/core/util/hive_box_name.dart';
import 'package:diary/feature/archive/model/archive_diary_model/archive_diary_model.dart';
import 'package:diary/feature/archive/view/widget/archive_card_widget.dart';
import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/empty_widget.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ArchiveDiaryModel>(HiveBoxName.ArchiveDiaryModelBox).listenable(),
        builder: (context, Box<ArchiveDiaryModel> box, child) {
          final archiveDiaries = box.values.toList();

          if (archiveDiaries.isEmpty) {
            return const EmptyWidget(
              image: AppPng.emptyArchive,
              message: "No Archived Diaries Found",
            );
          }

          return Column(
            children: [
              const SizedBox(height: 6),
              Expanded(
                child: ListView.builder(
                  itemCount: archiveDiaries.length,
                  itemBuilder: (context, index) {
                    final ArchiveDiaryModel = archiveDiaries[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: ArchiveCardView(
                        archiveDiaryModel: ArchiveDiaryModel,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
