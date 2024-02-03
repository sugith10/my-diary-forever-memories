import 'package:flutter/material.dart';

class NoDiaries extends StatelessWidget {
  const NoDiaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_area/entry_not_found.png'),
        const Text(
          'Capture the beauty of your memories',
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
