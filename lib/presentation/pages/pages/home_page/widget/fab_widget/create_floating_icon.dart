import 'package:diary/presentation/utils/assets/app_png.dart';
import 'package:flutter/material.dart';

class CreateFloatIcon extends StatelessWidget {
  const CreateFloatIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppPng.fab,
      width: 40,
      height: 40,
    );
  }
}
