import 'package:diary/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Center(
            child: Text(
              'hello',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.access_alarm_sharp, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                    }, icon: Icon(Icons.account_circle_outlined,color: Colors.black)),
                    ))
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
                child: TableCalendar(
                  firstDay: DateTime(2000, 10, 1),
                  lastDay: DateTime(2025, 12, 31),
                  focusedDay: DateTime(2023, 10, 10),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red)),
                  weekendDays: [DateTime.sunday],
                ),
                color: Color.fromARGB(255, 237, 237, 237),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Text(
                      '"In the journal, I do not just express\n myself more openly than I could to any person; I create myself."',
                      style: TextStyle(color: Colors.black26)),
                ),
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
                      onPressed: () {},
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
                    )
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
