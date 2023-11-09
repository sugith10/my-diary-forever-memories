import 'package:diary/screens/home/mainscreen.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var hour = 1;
  var minute = 1;
  var timeFormat = "AM";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),

          //       actions: [
          //          SizedBox(
          //   width: 120, // Same width as the leading icon.
          //   child: Center(
          //     child: Text(
          //       'Notifications',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),
          //       ],
          elevation: 0,
          centerTitle: true,
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
        //bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 30.h,
              width: 100.w,
              // color: Colors.amber,
              
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Notifications",
                          style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi'),
                      ),
                      
                    ),
                   
                    SizedBox(
                      height: 2.h,
                    ),
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Let us know when you'd like to receive reminders \nto jot down your daily moments, and we'll\nmake sure it's precisely when you want.",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ),
                 
                  ],
                ),
              ),
            ),
            // Text(
            //   'You will get a reminder at this time',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w500,
            //       fontFamily: 'Satoshi'),
            // ),
          SizedBox(height: 2.h,),
            Container(
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Center(
                    child: NumberPicker(
                        minValue: 1,
                        maxValue: 12,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        },
                        textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                            ),
                            bottom: BorderSide(color: Colors.grey)),
                      ),
                        ),
                  ),
                   Center(
                    child: NumberPicker(
                        minValue: 1,
                        maxValue: 59,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                        },
                        textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                            ),
                            bottom: BorderSide(color: Colors.grey)),
                      ),
                        ),
                  ),
                  SizedBox(width: 5.w,),
                   Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = "AM";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: timeFormat == "AM"
                                  ? Colors.grey.shade800
                                  : Color.fromARGB(255, 186, 183, 183),
                              border: Border.all(
                               color: Colors.black
                              )),
                          child: const Text(
                            "AM",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 1.5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timeFormat = "PM";
                          });
                          
                          print('pm');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: timeFormat == "PM"
                                ? Colors.grey.shade800
                                : Color.fromARGB(255, 186, 183, 183),
                            border: Border.all(
                              color: Colors.black
                            ),
                          ),
                          child: const Text(
                            "PM",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      )
                    ],
                  )
                
              
            
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Spacer(),
            Container(
              height: 55,
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  width: 2,
                  color: Color(0xFFE2E8F0),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi'),
                    backgroundColor: Color(0xFF835DF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16)),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 100),
                  child: Text('Set notification time'),
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
