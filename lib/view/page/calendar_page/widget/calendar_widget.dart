import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../data/model/hive/diary_entry_db_model/diary_entry.dart';
import '../../../../view_model/providers/calendar_scrn_prvdr.dart';
import '../../../theme/color/app_color.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.calenderProvider,
  });

  final CalenderPageProvider calenderProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            isSameDay(day, calenderProvider.selectedDate),
        firstDay: DateTime(2022, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: calenderProvider.selectedDate,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.red),
        ),
        weekendDays: const [DateTime.sunday],
        onDaySelected: (day, focusedDay) {
          calenderProvider.selectDate(day);
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.pink,
            ),
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: Colors.white),
          selectedDecoration:
              const BoxDecoration(color: Colors.pink, shape: BoxShape.circle
                  // borderRadius: BorderRadius.circular(12),
                  ),
          selectedTextStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          weekendTextStyle: const TextStyle(color: Colors.red),
        ),
        eventLoader: (day) {
          final hasDiaryEntry = Hive.box<DiaryEntry>('diaryEntryBox')
              .values
              .any((entry) => isSameDay(entry.date, day));
          return hasDiaryEntry ? [day] : [];
        },
      ),
    );
  }
}
