import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/pages/pages/widget/back_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: const BackButtonWidget(),
        elevation: 0,
        bottom: const BottomBorderWidget());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
