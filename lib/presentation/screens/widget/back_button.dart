import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(FocusNode()); 
      },
      icon: const Icon(
        Ionicons.chevron_back_outline,
        size: 25,
      ),
    );
  }
}
