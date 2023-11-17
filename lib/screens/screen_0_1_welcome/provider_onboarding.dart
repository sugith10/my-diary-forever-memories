import 'package:flutter/material.dart';

class OnboardingState with ChangeNotifier {
  int currentIndex = 0;

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
