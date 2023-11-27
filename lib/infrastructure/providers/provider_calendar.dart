import 'package:flutter/material.dart';

class Changer with ChangeNotifier{
  bool _isCalendarVisible = true;
  DateTime _selectedDate = DateTime.now(); // Store the selected date

  bool get isCalendarVisible => _isCalendarVisible;
  DateTime get selectedDate => _selectedDate; // Getter for the selected date

  void toggleCalendarVisibility() {
    _isCalendarVisible = !_isCalendarVisible;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date; // Update the selected date
    notifyListeners();
  }

}