import 'package:diary/screens/screen5_create/create_page.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({super.key});

  DateTime today = DateTime.now();

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<Changer>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              onTap: () {
                changer.toggleCalendarVisibility();
              },
              child: Row(
                children: [
                 Consumer<Changer>(
                    builder: (context, changer, child) {
                      return Text(
                        DateFormat('d MMMM,y').format(changer.selectedDate),
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  Icon(
                    changer.isCalendarVisible
                        ? Ionicons.chevron_down_outline
                        : Ionicons
                            .chevron_up_outline, 
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 0.1,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              // color: Color.fromARGB(255, 237, 237, 237),
              child: Container(
                // color: Color.fromARGB(255, 237, 237, 237),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Visibility(
                  visible: changer.isCalendarVisible,
                  child: TableCalendar(
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, changer.selectedDate),
                    firstDay: DateTime(2000, 10, 1),
                    lastDay: DateTime(2025, 12, 31),
                    focusedDay: changer.selectedDate,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    weekendDays: [DateTime.sunday],
                    onDaySelected: (day, focusedDay) {
                      changer.selectDate(day);
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
               Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: CreatePage(changer: changer,)));

              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start writing about your day...',
                            style: TextStyle(
                              color: Color.fromARGB(255, 31, 31, 31),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Click this text to create your personal diary',
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget customIcon() {
  return Image.asset(
    'images/start_writing.png',
    width: 64,
    height: 64,
  );
}
