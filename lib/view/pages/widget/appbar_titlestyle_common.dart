import 'package:flutter/material.dart';

class AppbarTitleWidget extends StatelessWidget {
  final String text;

  const AppbarTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'SFPRO',
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
