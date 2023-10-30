import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isFocusedEmail = false;
  bool isFocusedPassword = false;

  get focusNodePassword => null;

  get focusNodeEmail => null;

  void setFocusedEmail(bool value) {
    isFocusedEmail = value;
    notifyListeners();
  }

  void setFocusedPassword(bool value) {
    isFocusedPassword = value;
    notifyListeners();
  }
}
