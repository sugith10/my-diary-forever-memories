import 'package:flutter/material.dart';

part "dark_mode_colors.dart";
part "light_mode_colors.dart";

/// Interface for defining colors used in the application's UI.
interface class _AppColors {
  final Color background;
  final Color primaryText;
  final Color secondaryText;
  final Color card;
  final Color menu;
  final Color danger;
  final Color success;
  final Color focus;
  final Color unfocus;
  final Color pageOne;
  final Color pageTwo;
  final Color pageThree;
  final Color pageFour;
  final Color elevatedButton;
 
  _AppColors({
    required this.secondaryText,
    required this.pageOne,
    required this.pageTwo,
    required this.pageThree,
    required this.pageFour,
    required this.background,
    required this.primaryText,
    required this.card,
    required this.menu,
    required this.danger,
    required this.focus,
    required this.success,
    required this.unfocus,
    required this.elevatedButton,
  });
}

