import 'package:diary/models/archive_db_model.dart';
import 'package:diary/presentation/screens/archive_screen/widget/archive_card_view.dart';
import 'package:diary/presentation/screens/saved_list_screen/widget/not_found.dart';
import 'package:diary/presentation/screens/widget/appbar_with_back_button_only_common.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ArchiveDiary>('archiveDiaryEntryBox').listenable(),
        builder: (context, Box<ArchiveDiary> box, child) {
          final archiveDiaries = box.values.toList();

          if (archiveDiaries.isEmpty) {
            return const Center(
              child: NotFound(message: "No archived diaries."),
            );
          }

          return ListView.builder(
            itemCount: archiveDiaries.length,
            itemBuilder: (context, index) {
              final archiveDiary = archiveDiaries[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: ArchiveCardView(archiveDiary: archiveDiary,),
              );
            },
          );
        },
      ),
    );
  }
}
