import 'package:flutter/material.dart';

import '../../../../core/route/page_transition/bottom_to_top.dart';
import '../../../../view/page/create_page/create_page.dart';
import '../../../../view/util/get_colors.dart';
import '../../../../view_model/providers/calendar_scrn_prvdr.dart';

class CreateDiaryTextActionWidget extends StatelessWidget {
  const CreateDiaryTextActionWidget({
    super.key,
    required this.changer,
  });

  final CalenderPageProvider changer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).push(
                bottomToTop(
                  CreateDiaryPage(
                    changer: changer,
                    selectedColor: GetColors().getThemeColor(context),
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: _CreateDiaryText(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateDiaryText extends StatelessWidget {
  const _CreateDiaryText();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Start writing about your day...',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Click this text to create your personal diary',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
