import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../data/model/hive/diary_entry_db_model/diary_entry.dart';
import '../../route/page_transition/bottom_to_top.dart';
import '../../../view_model/providers/calendar_scrn_prvdr.dart';
import '../../util/get_colors.dart';
import '../create_page/create_page.dart';
import '../individual_diary_page/individual_diary_page.dart';
import '../home_page/widget/diary_card_widget/dairy_card.dart';
import 'widget/calendar_widget.dart';
import 'widget/calendart_page_app_bar.dart';
import 'widget/create_diary_text.dart';

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
                                bottomToTop(DiaryDetailPage(
                                  entry: selectedEntries[index],
                                )));
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(bottomToTop(CreateDiaryPage(
                              changer: changer,
                              selectedColor: GetColors().getThemeColor(context),
                            )));
                          },
                          child: const CreateDiaryText(),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
