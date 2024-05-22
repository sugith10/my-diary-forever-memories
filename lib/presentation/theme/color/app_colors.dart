import 'package:flutter/material.dart';

part "dark_mode_colors.dart";
part "light_mode_colors.dart";

/// Interface for defining colors used in the application's UI.
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

