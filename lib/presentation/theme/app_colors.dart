import 'package:flutter/material.dart';

interface class _AppColors {
  final Color background;
  final Color text;
  final Color card;
  final Color menu;
  final Color danger;
  final Color success;
  final Color focus;
  final Color unfocus;
  _AppColors({
    required this.background,
    required this.text,
    required this.card,
    required this.menu,
    required this.danger,
    required this.focus,
    required this.success,
    required this.unfocus,
  });
}

class MyAppDarkColor extends _AppColors {
  static MyAppDarkColor? _instance;
  static MyAppDarkColor get instance {
    _instance ??= MyAppDarkColor._();
    return _instance!;
  }

  MyAppDarkColor._()
      : super(
          background: const Color.fromARGB(255, 00, 00, 00),
          card: const Color.fromARGB(255, 25, 25, 25),
          danger: const Color.fromRGBO(239, 83, 80, 1),
          menu: const Color.fromARGB(255, 33, 33, 33),
          success: const Color.fromRGBO(102, 187, 106, 1),
          focus: const Color(0xFF198C53),
          unfocus: const Color.fromARGB(255, 183, 184, 185),
          text: const Color.fromRGBO(255, 255, 255, 1)
        );
}
