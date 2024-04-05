import 'package:diary/core/data/model/hive/hive_database_model/archive_db_model/archive_db_model.dart';
import 'package:diary/core/presentation/pages/pages/archive_page/widget/archive_card_widget.dart';
import 'package:diary/core/presentation/pages/pages/widget/not_found.dart';
import 'package:diary/core/presentation/pages/pages/widget/appbar_with_back_button_only_common.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ArchiveDiary>('archiveDiaryBox').listenable(),
        builder: (context, Box<ArchiveDiary> box, child) {
          final archiveDiaries = box.values.toList();

          if (archiveDiaries.isEmpty) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/empty_area/archived_not_found.png'),
                  const NotFound(message: "No archived diaries."),
                ]);
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