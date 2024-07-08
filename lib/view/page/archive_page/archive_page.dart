import 'package:diary/data/model/hive/hive_box_name.dart';
import 'package:diary/data/model/hive/archive_db_model/archive_db_model.dart';
import 'package:diary/view/page/archive_page/widget/archive_card_widget.dart';
import 'package:diary/utils/assets/app_png.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/app_custom_app_bar.dart';
import '../../components/empty_widget.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ArchiveDiary>(HiveBoxName.archiveDiaryBox).listenable(),
        builder: (context, Box<ArchiveDiary> box, child) {
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
                    final archiveDiary = archiveDiaries[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: ArchiveCardView(
                        archiveDiary: archiveDiary,
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
