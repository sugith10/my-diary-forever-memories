import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:flutter/material.dart';

import '../../../diary/view/page/create_page/page/create_page.dart';
import 'create_floating_icon.dart';

class CreatePageFAB extends StatelessWidget {
  const CreatePageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // shape: const CircleBorder(),

      onPressed: () {
        Navigator.of(context).push(
          bottomToTop(
            const CreateDiaryPage(),
          ),
        );
      },
      elevation: 3,
      child: const CreateFloatIcon(),
    );
  }
}
