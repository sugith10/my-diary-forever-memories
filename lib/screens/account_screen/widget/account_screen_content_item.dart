import 'package:diary/color/primary_colors.dart';
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
              ? Color(0xFFF1F5FF)
              : Color.fromARGB(255, 212, 214, 221).withOpacity(0.2),
          child: Icon(icon,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white),
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
