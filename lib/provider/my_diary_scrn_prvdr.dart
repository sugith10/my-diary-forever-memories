import 'package:flutter/material.dart';

class MyDiaryScreenProvider extends ChangeNotifier {
  DateTimeRange? _selectedDateRange;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  void setSelectedDateRange(DateTimeRange? dateRange) {
    _selectedDateRange = dateRange;
    notifyListeners();
  }
}
