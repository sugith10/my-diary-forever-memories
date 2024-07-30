import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  final String text;

  const AppbarTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
