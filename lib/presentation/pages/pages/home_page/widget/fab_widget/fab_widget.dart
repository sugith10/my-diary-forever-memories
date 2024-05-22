import 'package:diary/presentation/navigation/screen_transitions/bottom_to_top.dart';
import 'package:diary/presentation/providers/calendar_scrn_prvdr.dart';
import 'package:diary/presentation/pages/pages/create_page/create_page.dart';
import 'package:diary/presentation/pages/pages/home_page/widget/fab_widget/create_floating_icon.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/pages/util/get_colors.dart';
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
