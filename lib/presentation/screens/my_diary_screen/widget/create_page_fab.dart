import 'package:diary/infrastructure/providers/provider_calendar.dart';
import 'package:diary/presentation/screens/create_screen/create_page.dart';
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

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: CreateDiaryPage(
                        changer: changer,
                        selectedColor: GetColors().getThemeColor(context))));
          },
          elevation: 3,
          child: const CreateFloatIcon(),
        );
  }
}