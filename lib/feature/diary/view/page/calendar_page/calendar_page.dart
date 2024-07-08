import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../data/model/hive/diary_entry_db_model/diary_entry.dart';
import '../../../../../core/route/page_transition/bottom_to_top.dart';
import '../../../../../view_model/providers/calendar_scrn_prvdr.dart';
import '../../../../../view/page/individual_diary_page/individual_diary_page.dart';
import '../../../../home/widget/diary_card_widget/dairy_card.dart';
import 'widget/calendar_widget.dart';
import 'widget/calendar_page_app_bar.dart';
import '../../widget/create_diary_text_action_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool diaryFound = false;
  DiaryEntry? diaryEntryForSelectedDate;

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<CalenderPageProvider>(context);

    return Scaffold(
      appBar: CalendarPageAppBar(changer: changer),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Visibility(
              visible: changer.isCalendarVisible,
              child: CalendarWidget(calenderProvider: changer),
            ),
          ),
          ValueListenableBuilder<Box<DiaryEntry>>(
            valueListenable: Hive.box<DiaryEntry>('diaryEntryBox').listenable(),
            builder: (context, box, child) {
              List<DiaryEntry> diaryEntries = box.values.toList();
              final selectedEntries = diaryEntries
                  .where((entry) => isSameDay(entry.date, changer.selectedDate))
                  .toList();
              if (selectedEntries.isNotEmpty) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              bottomToTop(
                                DiaryDetailPage(
                                  entry: selectedEntries[index],
                                ),
                              ),
                            );
                          },
                          child: DiaryCardView(
                            entry: selectedEntries[index],
                          ),
                        ),
                      );
                    },
                    childCount: selectedEntries.length,
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: CreateDiaryTextActionWidget(changer: changer),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
