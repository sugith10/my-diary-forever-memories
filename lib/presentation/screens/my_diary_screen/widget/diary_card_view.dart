import 'dart:developer';
import 'package:diary/application/controllers/hive_diary_entry_db_ops.dart';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/individual_diary_screen/individual_diary_screen.dart';
import 'package:diary/presentation/screens/widget/dairy_card_view_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final int index;

  const DiaryEntryCard(this.entry, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          if (entry.id != null) {
            DbFunctions().deleteDiary(entry.id!);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                content: Text(
                  "Successfully Deleted",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            log('no data found');
          }
        }),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              if (entry.id != null) {
                DbFunctions().deleteDiary(entry.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(2.h),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                    content: const Text(
                      "Successfully Deleted",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.bottomCenter,
                  child: DiaryDetailPage(
                    entry: entry,
                  )));
        },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
            child: DiaryCardView(entry: entry)),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
