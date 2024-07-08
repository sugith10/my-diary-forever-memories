import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../components/svg_icon.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    required this.function,
    required this.item,
    required this.icon,
    super.key,
  });

  final Function function;
  final String item;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.5),
      ),
      onTap: () {
        function();
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFFF1F5FF)
                : const Color.fromARGB(255, 25, 25, 25),
            child: SvgIcon(path: icon),
          ),
          const SizedBox(
            width: 18,
          ),
          Text(
            item,
            style: TextStyle(fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}
