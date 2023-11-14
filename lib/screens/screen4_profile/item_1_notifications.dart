import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/widgets/appbar_bottom.dart';
import 'package:diary/screens/widgets/info_container.dart';
import 'package:flutter/material.dart';
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
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            InfoContainer(
              title: "Notifications",
              description:
                  "Let us know when you'd like to receive reminders to jot down your daily moments, and we'll make sure it's precisely when you want.",
            ),

            // Text(
            //   'You will get a reminder at this time',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w500,
            //       fontFamily: 'Satoshi'),
            // ),
            SizedBox(
              height: 2.h,
            ),
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
                      selectedTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
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
                      selectedTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                            ),
                            bottom: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
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
                                  : const Color.fromARGB(255, 186, 183, 183),
                              border: Border.all(color: Colors.black)),
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

                        
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: timeFormat == "PM"
                                ? Colors.grey.shade800
                                : const Color.fromARGB(255, 186, 183, 183),
                            border: Border.all(color: Colors.black),
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
            SizedBox(
              height: 2.h,
            ),
            const Spacer(),
            Container(
              height: 55,
              margin:const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    textStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi'),
                    backgroundColor: const Color(0xFF835DF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 100),
                  child: const Text('Set notification time'),
                ),
              ),
            ),
           const Spacer(),
          ],
        ),
      ),
    );
  }
}
