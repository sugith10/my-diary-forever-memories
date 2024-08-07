import 'package:flutter/material.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/appbar_titlestyle_common.dart';

class AccountPageAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AccountPageAppBar({
    super.key,
    required this.greetingTitle,
  });

  final String greetingTitle;

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: AppbarTitle(
        text: greetingTitle,
      ),
      children: [
        IconButton(
          onPressed: () {
            // ProfileScreenFunctions().showPopupDialog(context);
          },
          icon: const Icon(
            Icons.power_settings_new_outlined,
            color: Color.fromARGB(255, 197, 60, 50),
          ),
        ),
      ],
    );
  }

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}