import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../util/get_theme_type.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  const SvgIcon({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        isDark(context) ? Colors.white : const Color.fromARGB(255, 31, 31, 31),
        BlendMode.srcIn,
      ),
    );
  }
}
