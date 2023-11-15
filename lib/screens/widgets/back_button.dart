import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Ionicons.chevron_back_outline,
        color: Colors.black,
        size: 29,
      ),
    );
  }
}
