import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/calendar_screen/widget/create_diary_text.dart';
import 'package:diary/color/primary_colors.dart';
import 'package:diary/screens/my_diary_screen/mydiary_screen.dart';
import 'package:diary/screens/create_screen/create_page.dart';
import 'package:diary/providers/provider_calendar.dart';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  final DateTime today = DateTime.now();
  bool diaryFound = false;
  DiaryEntry? diaryEntryForSelectedDate;

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<Changer>(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: () {
              changer.toggleCalendarVisibility();
            },
            child: Row(
              children: [
                Consumer<Changer>(
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
                                  ? AppColor.black.color
                                  : Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat.d().format(today),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0,
          bottom: const BottomBorderWidget()),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Visibility(
              visible: changer.isCalendarVisible,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 15.sp,
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
                        color: AppColor.primary.color, shape: BoxShape.circle),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    weekendTextStyle: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<Box<DiaryEntry>>(
                valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
                builder: (context, box, child) {
                  // Fetch all diary entries
                  List<DiaryEntry> diaryEntries = box.values.toList();

                  final selectedEntries = diaryEntries
                      .where((entry) =>
                          isSameDay(entry.date, changer.selectedDate))
                      .toList();

                  if (selectedEntries.isNotEmpty) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: selectedEntries.length,
                      itemBuilder: (context, index) {
                        return DiaryEntryCard(selectedEntries[index], index);
                      },
                    );
                  } else {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: CreatePage(
                                    changer: changer,
                                  )));
                        },
                        child: const CreateDiaryText(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
