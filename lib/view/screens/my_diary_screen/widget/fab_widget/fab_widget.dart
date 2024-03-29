import 'package:diary/core/utils/screen_transitions/bottom_to_top.dart';
import 'package:diary/provider/calendar_scrn_prvdr.dart';
import 'package:diary/view/screens/create_screen/create_screen.dart';
import 'package:diary/view/screens/my_diary_screen/widget/fab_widget/create_floating_icon.dart';
import 'package:diary/view/theme/app_color.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePageFAB extends StatelessWidget {
  const CreatePageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // shape: const CircleBorder(),
      backgroundColor:  Theme.of(context).brightness == Brightness.light
            ? AppColor.lightCard.color
            : AppColor.darkCard.color,
      onPressed: () {
        final changer =
            Provider.of<CalenderScreenProvider>(context, listen: false);
        Navigator.of(context).push(
          bottomToTop(
            CreateDiaryPage(
              changer: changer,
              selectedColor: GetColors().getThemeColor(context),
            ),
          ),
        );
      },
      elevation: 3,
      child: const CreateFloatIcon(),
    );
  }
}
