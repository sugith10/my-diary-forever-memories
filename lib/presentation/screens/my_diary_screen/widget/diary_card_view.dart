import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
        dismissible: DismissiblePane(onDismissed: () {
          // print('Start Action Dismissed');
        }),
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
            //  diaryEntriesNotifier.notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Successfully Deleted"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(2.h),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
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
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Successfully Deleted...',
                    message:
                        'This is an example error message that will be shown in the body of snackbar!',
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
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
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=> DiaryDetailPage(entry: entry,)));
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
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: DiaryCardView(entry: entry)
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

