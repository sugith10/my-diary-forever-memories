import 'package:flutter/material.dart';

class CreateDiaryProvider extends ChangeNotifier {
  Color background;
  CreateDiaryProvider({required this.background});

  void changeBackground(Color color) {
    background = color;
    notifyListeners();
  }
}
