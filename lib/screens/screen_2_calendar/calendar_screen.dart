import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen_1_my_diary/mydiary_screen.dart';
import 'package:diary/screens/screen_5_create/create_page.dart';
import 'package:diary/screens/screen_2_calendar/provider_calendar.dart';
import 'package:diary/screens/widgets/appbar_titlestyle.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  //  bool diaryFound = false;
  DiaryEntry? diaryEntryForSelectedDate;

  Future<void> fetchDiaryEntryForDate(DateTime selectedDate) async {
    final dbFunctions = DbFunctions();
    await dbFunctions.getAllDiary(); // Fetch all diary entries
    List<DiaryEntry> diaryEntries = dbFunctions.diaryEntryNotifier;

    // Find the diary entry for the selected date
    diaryEntryForSelectedDate = null;
    bool foundEntry = false;
    for (var entry in diaryEntries) {
      if (entry.date == selectedDate) {
        foundEntry = true;
        diaryEntryForSelectedDate = entry;
        print('Diary entry found: ${diaryEntryForSelectedDate!.title}');
        print('Date: ${diaryEntryForSelectedDate!.date}');
      }
    }
    if (foundEntry == false) {
      print('No diary entry found for selected date.');
      // Handle if there's no diary entry for the selected date
    }
  }

  // final int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<Changer>(context);
    fetchDiaryEntryForDate(changer.selectedDate);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
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
                  color: Colors.black,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat.d()
                          .format(today), // Display only the current day
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black,
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
          // color: Color.fromARGB(255, 237, 237, 237),
          Container(
            // color: Color.fromARGB(255, 237, 237, 237),
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Visibility(
              visible: changer.isCalendarVisible,
              child: TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  // decoration: BoxDecoration(
                  //   color: Colors.blueGrey[50], // Change the header background color
                  // ),
                  titleTextStyle: TextStyle(
                    color: Colors.blueGrey[900], // Change header text color
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) =>
                    isSameDay(day, changer.selectedDate),
                firstDay: DateTime(2021, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: changer.selectedDate,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                weekendDays: const [DateTime.sunday],
                onDaySelected: (day, focusedDay) {
                  changer.selectDate(day);
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 77, 76, 78),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.white),
                  selectedDecoration: BoxDecoration(
                      color: Color(0xFF835DF1), shape: BoxShape.circle),
                  selectedTextStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  weekendTextStyle: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
       Expanded(
            child: ValueListenableBuilder<Box<DiaryEntry>>(
              valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
              builder: (context, box, child) {
                final diaryEntries = box.values.toList();
                return ListView.builder(
                  itemCount: diaryEntries.length,
                  itemBuilder: (context, index) {
                    final entry = diaryEntries[index];

                    return DiaryEntryCard(entry, index, key: ValueKey(entry.id));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGroupedDiaryEntries(List<DiaryEntry> entries, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              fontSize: 20.0,
            ),
          ),
        ),
        Column(
          children: entries.map((entry) {
            return DiaryEntryCard(entry, entries.indexOf(entry),
                key: ValueKey(entry.id));
          }).toList(),
        ),
      ],
    );
  }
}
