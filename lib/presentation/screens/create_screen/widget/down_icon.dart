import 'package:diary/presentation/util/create_page_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CaretDown extends StatelessWidget {
  const CaretDown({super.key, required this.selectedColor});

  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Ionicons.caret_down_outline,
      color: CreateDiaryScreenFunctions().isColorBright(selectedColor)
          ? Colors.black
          : Colors.white,
    );
  }
}
