import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen_5_create/create_page.dart';
import 'package:diary/screens/screen_2_calendar/provider_calendar.dart';
import 'package:diary/screens/widgets/appbar_titlestyle.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime today = DateTime.now();

   bool diaryFound = false;
    DiaryEntry? diaryEntryForSelectedDate;

  // final int currentIndex = 0;
   Future<void> fetchDiaryEntryForDate(DateTime selectedDate) async {
    final dbFunctions = DbFunctions();
    await dbFunctions.getAllDiary(); // Fetch all diary entries
    List<DiaryEntry> diaryEntries = dbFunctions.diaryEntryNotifier;

    // Find the diary entry for the selected date
   
    for (var entry in diaryEntries) {
      if (entry.date.year == selectedDate.year &&
          entry.date.month == selectedDate.month &&
          entry.date.day == selectedDate.day) {
        diaryEntryForSelectedDate = entry;
        break;
      }
    }

    if (diaryEntryForSelectedDate != null) {
      // If a diary entry exists for the selected date, print it
      print('Diary entry found: ${diaryEntryForSelectedDate!.title}');
      print('Content: ${diaryEntryForSelectedDate!.content}');
      // Display or use this information as needed
     diaryFound = true;
    } else {
      diaryFound = false;
      print('No diary entry found for selected date.');
      // Handle if there's no diary entry for the selected date
    }
  }

  @override
  Widget build(BuildContext context) {
    final changer = Provider.of<Changer>(context);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: InkWell(
            onTap: ()  {
         
              changer.toggleCalendarVisibility();
            },
            child: Row(
              
              children: [
                Consumer<Changer>(
                  builder: (context, changer, child) {
                    return AppbarTitleWidget(
                      text: DateFormat('d MMMM,y').format(changer.selectedDate),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Icon(
                  changer.isCalendarVisible
                      ? Ionicons.chevron_down_outline
                      : Ionicons.chevron_up_outline,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          actions: [
           
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat.d().format(today), // Display only the current day
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ],
          elevation: 0,
          bottom: const BottomBorderWidget()),
      body: Column(
        children: [
        
            // color: Color.fromARGB(255, 237, 237, 237),
            Container(
              // color: Color.fromARGB(255, 237, 237, 237),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Visibility(
                visible: changer.isCalendarVisible,
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    // decoration: BoxDecoration(
                    //   color: Colors.blueGrey[50], // Change the header background color
                    // ),
                    titleTextStyle: TextStyle(
                      color: Colors.blueGrey[900], // Change header text color
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => 

                      isSameDay(day, changer.selectedDate),
                  firstDay: DateTime(2000, 10, 1),
                  lastDay: DateTime.now(),
                  focusedDay: changer.selectedDate,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                  weekendDays: const [DateTime.sunday],
                  onDaySelected: (day, focusedDay)async {
                         await fetchDiaryEntryForDate(changer.selectedDate);
                    changer.selectDate(day);
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 77, 76, 78),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                        color: Color(0xFF835DF1),
                        shape: BoxShape.circle),
                    selectedTextStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    weekendTextStyle: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          
          const Spacer(),
          InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: CreatePage(
                        changer: changer,
                      )));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: diaryFound == true ?  Column(
                children: [
             Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                     diaryEntryForSelectedDate!.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  diaryEntryForSelectedDate!.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 105, 105, 105)
                  ),
                ),
                const SizedBox(height: 12.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       DateFormat('d MMMM, y').format(entry.date),
                //       style: const TextStyle(
                //         fontSize: 14.0,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
       
                ],
              ) : const  Column(
                children: [
                    Row(
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
                 
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Click this text to create your personal diary',
                    style: TextStyle(color: Colors.black26, fontSize: 12),
                  ),
                ],
              ),
              // child: const 
            
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
