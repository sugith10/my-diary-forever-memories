import 'package:diary/model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/core/utils/screen_transitions/bottom_to_top.dart';
import 'package:diary/view/screens/calendar_screen/widget/create_diary_text.dart';
import 'package:diary/view/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:diary/view/screens/my_diary_screen/widget/diary_card_widget/dairy_card.dart';
import 'package:diary/view/theme/app_color.dart';
import 'package:diary/view/screens/create_screen/create_screen.dart';
import 'package:diary/provider/calendar_scrn_prvdr.dart';
import 'package:diary/view/screens/widget/appbar_titlestyle_common.dart';
import 'package:diary/view/screens/widget/appbar_bottom_common.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  final DateTime today = DateTime.now();
  bool diaryFound = false;
  DiaryEntry? diaryEntryForSelectedDate;

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<CalenderScreenProvider>(context);

    return Scaffold(
//appbar starting
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onTap: () {
            changer.toggleCalendarVisibility();
          },
          child: Row(
            children: [
              Consumer<CalenderScreenProvider>(
                builder: (context, changer, child) {
                  return AppbarTitleWidget(
                    text: DateFormat('d MMMM,y').format(changer.selectedDate),
                  );
                },
              ),
              const SizedBox(width: 10),
              Icon(
                changer.isCalendarVisible
                    ? Ionicons.chevron_down_outline
                    : Ionicons.chevron_up_outline,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    changer.selectDate(DateTime.now());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? AppColor.dark.color
                                : Colors.white,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.d().format(today),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
////appbar ending

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Visibility(
                visible: changer.isCalendarVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, changer.selectedDate),
                    firstDay: DateTime(2022, 1, 1),
                    lastDay: DateTime.now(),
                    focusedDay: changer.selectedDate,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    weekendDays: const [DateTime.sunday],
                    onDaySelected: (day, focusedDay) {
                      changer.selectDate(day);
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: AppColor.secondary.color,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: const TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: AppColor.primary.color,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      weekendTextStyle: const TextStyle(color: Colors.red),

                      // defaultTextStyle: TextStyle(color: Colors.grey)
                    ),
                    eventLoader: (day) {
                      final hasDiaryEntry = Hive.box<DiaryEntry>('diaryEntryBox')
                          .values
                          .any((entry) => isSameDay(entry.date, day));
                      return hasDiaryEntry ? [day] : [];
                    },
                  ),
                ),
              ),
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
