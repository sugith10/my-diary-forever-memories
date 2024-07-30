import 'package:diary/core/util/asset_path/app_svg.dart';
import 'package:diary/core/widget/svg_icon.dart';
import 'package:diary/core/util/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    required this.function,
    required this.item,
    this.svg,
   required  this.icon,
    super.key,
  });

  final Function function;
  final String item;
  final String? svg;
  final IconData? icon;

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
            backgroundColor: IsDark.check(context)
                ? const Color.fromARGB(255, 25, 25, 25)
                : const Color(0xFFF1F5FF),
            child:icon != null ? Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ) : SvgIcon(path: svg ?? AppSvg.darkMode),
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
