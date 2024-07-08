import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int seconds;
  Timer? _timer;
  Debouncer({required this.seconds});

  void run({required VoidCallback callback}) {
    // Cancel any existing timer
    _timer?.cancel();
    _timer = Timer(
      Duration(
        seconds: seconds,
      ),
      callback,
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}
