import 'package:flutter/material.dart';

class BottomBorderWidget extends StatelessWidget implements PreferredSizeWidget {
  const BottomBorderWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light ?const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255),
          width: 0.1,
        ),
      ),
    );
  }
}
