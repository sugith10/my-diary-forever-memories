import 'package:diary/core/model/diary_model/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../feature/home/widget/diary_card_widget/diary_card_slide_widget/diary_card_actions.dart';

class MyDiaryScreenFunctions {
  Future<DateTimeRange?> _handleDateRangePick(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: now,
      locale: Localizations.localeOf(context),
      saveText: 'Done',
      builder: (BuildContext context, Widget? child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
               
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                 
                  ),
                ),
          child: child ?? Container(),
        );
      },
      initialEntryMode: Theme.of(context).brightness == Brightness.light
          ? DatePickerEntryMode.calendar
          : DatePickerEntryMode.input,
      helpText: 'Select Date Range',
      cancelText: 'Cancel',
      confirmText: 'OK',
      errorFormatText: 'Invalid date range format',
      errorInvalidText: 'Invalid date range',
      fieldStartHintText: 'Start Date',
      fieldEndHintText: 'End Date',
    );
    if (pickedDateRange != null) {
      final DateTime adjustedStartDate =
          pickedDateRange.start.subtract(const Duration(days: 1));
      final DateTime adjustedEndDate =
          pickedDateRange.end.add(const Duration(days: 1));

      final adjustedDateRange =
          DateTimeRange(start: adjustedStartDate, end: adjustedEndDate);

      return adjustedDateRange;
    }
    return pickedDateRange;
  }

  Future<DateTimeRange?> handleDateRangePick(BuildContext context) async {
    return _handleDateRangePick(context);
  }

  Widget _buildGroupedDiaryEntries(List<DiaryModel> entries, String date) {
    final formattedDate =
        DateFormat('d MMM y - EEEE').format(DateTime.parse(date));

    final dateParts = formattedDate.split(' - ');

    String getCommonDayAbbreviation(String fullDay) {
      return DateFormat.E().format(DateTime.parse(date)).substring(0, 3);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 10, left: 16, right: 8, top: 10),
          child: Row(
            children: [
              const SizedBox(width: 4),
              Text(
                dateParts[0],
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${getCommonDayAbbreviation(date)})', 
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: entries.map((entry) {
            return DiaryCardActions(entry, entries.indexOf(entry),
                key: ValueKey(entry.id));
          }).toList(),
        ),
      ],
    );
  }

  Widget buildGroupedDiaryEntries(List<DiaryModel> entries, String date) {
    return _buildGroupedDiaryEntries(entries, date);
  }
}
