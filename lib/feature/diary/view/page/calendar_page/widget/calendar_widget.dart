import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../core/model/diary_model/diary_model.dart';
import '../../../../view_model/provider/calendar_scrn_prvdr.dart';

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
          todayTextStyle: const TextStyle(
            color: Colors.pink,
          ),
          selectedDecoration:
              const BoxDecoration(color: Colors.pink, shape: BoxShape.circle
                  // borderRadius: BorderRadius.circular(12),
                  ),
          // selectedTextStyle: TextStyle(
          //   color: IsDark.check(context)
          //       ? Colors.white
          //       : const Color.fromARGB(255, 0, 0, 0),
          // ),
          weekendTextStyle: const TextStyle(color: Colors.red),
        ),
        eventLoader: (day) {
          final hasDiaryModel = Hive.box<DiaryModel>('DiaryModelBox')
              .values
              .any((entry) => isSameDay(entry.date, day));
          return hasDiaryModel ? [day] : [];
        },
      ),
    );
  }
}
