import 'dart:developer';

import 'package:flutter/material.dart';

class CalenderPageProvider extends ChangeNotifier{
  bool _isCalendarVisible = true;
  DateTime _selectedDate = DateTime.now();

  bool get isCalendarVisible => _isCalendarVisible;
  DateTime get selectedDate => _selectedDate;

  void toggleCalendarVisibility() {
    _isCalendarVisible = !_isCalendarVisible;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    log(date.toString());
    notifyListeners();
  }

}