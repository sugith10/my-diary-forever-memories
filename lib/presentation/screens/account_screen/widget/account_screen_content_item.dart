import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({required this.item, required this.icon, super.key});

  final String item;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? const Color(0xFFF1F5FF)
              : const Color.fromARGB(255, 25, 25, 25),
          child: Icon(icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : const Color.fromARGB(255, 171, 170, 170)),
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          item,
          style: TextStyle(fontSize: 14.sp),
        )
      ],
    );
  }
}
