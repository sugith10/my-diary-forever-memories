import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/my_diary_screen/widget/diary_card_view.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDiaryScreenFunctions {
  Future<DateTimeRange?> _handleDateRangePick(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime.now(),
      locale: Localizations.localeOf(context),
      saveText: 'Done',
      builder: (BuildContext context, Widget? child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: AppColor.primary.color,
                    secondary: AppColor.primary.color,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColor.primary.color,
                    secondary: AppColor.primary.color,
                  ),
                ),
          child: child ?? Container(),
        );
      },
      initialEntryMode: Theme.of(context).brightness == Brightness.light
          ? DatePickerEntryMode.calendar
          : DatePickerEntryMode.input,
      initialDateRange:
          DateTimeRange(start: DateTime(2023), end: DateTime.now()),
      helpText: 'Select Date Range',
      cancelText: 'Cancel',
      confirmText: 'OK',
      errorFormatText: 'Invalid date range format',
      errorInvalidText: 'Invalid date range',
      fieldStartHintText: 'Start Date',
      fieldEndHintText: 'End Date',
    );
    if (pickedDateRange != null) {
      final startDate = pickedDateRange.start;
      final endDate = pickedDateRange.end;
      final formattedStartDate = DateFormat('d MMMM, y').format(startDate);
      final formattedEndDate = DateFormat('d MMMM, y').format(endDate);
      print('Selected date range: $formattedStartDate - $formattedEndDate');
    }
    return pickedDateRange;
  }

  Future<DateTimeRange?> handleDateRangePick(BuildContext context) async {
    return _handleDateRangePick(context);
  }
Widget _buildGroupedDiaryEntries(List<DiaryEntry> entries, String date) {
  final formattedDate = DateFormat('d MMM - y  EEEE').format(DateTime.parse(date));

  // Split the formatted date to get the day and year separately
  final dateParts = formattedDate.split(' - ');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 16, right: 8, top: 8),
        child: Row(
          children: [
            Text(
              dateParts[0], // Day and Month
              style:  TextStyle(
                fontSize: 15.0,
                // color:Colors.grey, // Set your desired color
                fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(width: 4), // Add spacing between day and year
            Text(
              dateParts[1], // Year and Day of the week
              style: const TextStyle(
                fontSize: 15.0,
                // color: Colors.grey, // Set your desired color
              ),
            ),
          ],
        ),
      ),
      Column(
        children: entries.map((entry) {
          return DiaryEntryCard(entry, entries.indexOf(entry), key: ValueKey(entry.id));
        }).toList(),
      ),
    ],
  );
}


  Widget buildGroupedDiaryEntries(List<DiaryEntry> entries, String date) {
    return _buildGroupedDiaryEntries(entries, date);
  }
}
