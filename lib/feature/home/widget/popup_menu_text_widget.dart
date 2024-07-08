import 'package:flutter/material.dart';

class PopUpMenuText extends StatelessWidget {
  final String title;
  const PopUpMenuText({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.labelLarge,);
  }
}