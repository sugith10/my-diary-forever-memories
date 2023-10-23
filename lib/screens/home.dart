import 'package:diary/screens/profile.dart';
import 'package:diary/screens/create_page.dart';
import 'package:diary/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                DateFormat('d MMMM,y').format(today),
                style: TextStyle(color: Colors.black),
              ),
              IconButton(onPressed: (){}, icon: Icon(Ionicons.chevron_down_outline, color: Colors.black,))
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MySearchAppBar()));
              },
              icon: Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Ionicons.bookmarks_outline, color: Colors.black)),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  icon: Icon(Ionicons.person_outline, color: Colors.black)),
            )
          ],
          elevation: 0,
        ),
        body: Container(
          // margin: EdgeInsets.only(left: 20,right: 20),
          color: Colors.white,
          // margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 237, 237, 237),
                child: Container(
                  color: Color.fromARGB(255, 237, 237, 237),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TableCalendar(
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    firstDay: DateTime(2000, 10, 1),
                    lastDay: DateTime(2025, 12, 31),
                    focusedDay: today,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    weekendDays: [DateTime.sunday],
                    onDaySelected: _onDaySelected,
                    // selectedDayPredicate: (day) {
                    //   // Define the condition for the focused day and current day
                    //   final focusedDay = DateTime(2023, 10, 10);
                    //   return isSameDay(day, focusedDay) ||
                    //       isSameDay(day, DateTime.now());
                    // },
                    // calendarStyle: CalendarStyle(
                    //   selectedDecoration: BoxDecoration(
                    //     color: Colors
                    //         .blue, // Set your desired color for the focused day and current day
                    //     shape: BoxShape
                    //         .circle, // You can customize the shape as needed
                    //   ),
                    // ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    textAlign: TextAlign.center,
                    '"In the journal, I do not just express myself more openly than I could to any person; I create myself."',
                    style: TextStyle(color: Colors.black26)),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 2.0,
                indent: 185,
                endIndent: 185,
                color: Colors.black26,
              ),
              Text('Susan Sontag', style: TextStyle(color: Colors.black26)),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatePage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 237, 237, 237),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Start writing about your day...',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 31, 31),
                                fontSize: 20),
                          ),
                          customIcon(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Click this button to create your personal diary',
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

Widget customIcon() {
  return Image.asset(
    'images/start_writing.png',
    width: 64, // Adjust the width as needed
    height: 64, // Adjust the height as needed
  );
}
