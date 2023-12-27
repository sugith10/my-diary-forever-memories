import 'package:diary/presentation/screen_transition/fab_to_top.dart';
import 'package:diary/providers/provider_calendar.dart';
import 'package:diary/presentation/screens/create_screen/create_screen.dart';
import 'package:diary/presentation/screens/widget/create_floating_icon.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CreatePageFAB extends StatelessWidget {
  const CreatePageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        final changer = Provider.of<Changer>(context, listen: false);
       Navigator.of(context).push(fabToTop(CreateDiaryPage(
                    changer: changer,
                    selectedColor: GetColors().getThemeColor(context))));
      },
      elevation: 3,
      child: const CreateFloatIcon(),
    );
  }
}
