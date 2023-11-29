import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDiaryScreenFunctions {
  Future<void> _handleDateRangePick(BuildContext context) async {
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
  }

  Future<void> handleDateRangePick(BuildContext context) async {
    return _handleDateRangePick(context);
  }
}
