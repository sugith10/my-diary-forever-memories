import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/view_model/providers/calendar_scrn_prvdr.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view/page/create_page/create_page.dart';
import 'create_floating_icon.dart';

class CreatePageFAB extends StatelessWidget {
  const CreatePageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // shape: const CircleBorder(),

      onPressed: () {
        final changer =
            Provider.of<CalenderPageProvider>(context, listen: false);
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
