import 'package:diary/screens/widget/back_button.dart';
import 'package:diary/screens/widget/appbar_bottom.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

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


