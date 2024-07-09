import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../view_model/providers/calendar_scrn_prvdr.dart';
import '../../../../../../core/widget/custom_app_bar.dart';
import '../../../../../../view/page/widget/appbar_titlestyle_common.dart';

class CalendarPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CalendarPageAppBar({
    super.key,
    required this.changer,
  });

  final CalenderPageProvider changer;

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      title: Row(
        children: [
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () {
              changer.toggleCalendarVisibility();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Row(
                children: [
                  Consumer<CalenderPageProvider>(
                    builder: (context, changer, child) {
                      return AppbarTitle(
                        text:
                            DateFormat('d MMMM,y').format(changer.selectedDate),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    changer.isCalendarVisible
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Center(
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  changer.selectDate(DateTime.now());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat.d().format(DateTime.now()),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
