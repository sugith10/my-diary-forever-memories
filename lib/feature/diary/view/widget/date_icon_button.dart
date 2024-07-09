import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class DateIconButton extends StatelessWidget {
  const DateIconButton({
    super.key,
    required this.date,
    required this.callback,
  });

  final DateTime date;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        onPressed: () {
          callback();
        },
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('d MMMM,y').format(date),
            ),
            const Icon(IconlyBold.arrow_down_2)
          ],
        ),
      ),
    );
  }
}
