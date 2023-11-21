import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/start_writing.png',
      width: 40,
      height: 40,
    );
  }
}
