import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';

class NoDiaries extends StatefulWidget {
  const NoDiaries({super.key});

  @override
  State<NoDiaries> createState() => _NoDiariesState();
}

class _NoDiariesState extends State<NoDiaries> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppPng.emptyHome),
        const Text(
          'Capture Beauty of Your Memories',
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          'Never lose, always record.',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
