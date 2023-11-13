import 'dart:io';
import 'package:diary/db/hive_profile_operations.dart';
import 'package:diary/models/profile_details.dart';
import 'package:diary/screens/screen4_profile/item_1_notifications.dart';
import 'package:diary/screens/screen4_profile/item_2_customization.dart';
import 'package:diary/screens/screen4_profile/profile_page.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';


class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key});

  String getGreeting() {
    var now = DateTime.now();
    if (now.isAfter(DateTime(now.year, now.month, now.day, 0, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 12, 0))) {
      return '🤓 Good morning';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 12, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 18, 0))) {
      return '😏 Good afternoon';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 18, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 20, 0))) {
      return '😊 Good evening';
    } else {
      return '😍 How was your day?';
    }
  }

  @override
  Widget build(BuildContext context) {
    String greetingTitle = getGreeting();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(greetingTitle, style:  TextStyle(color: Colors.black, fontSize: 17.sp)),
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1, 0, 0, 5),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'Edit Profile',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined),
                        SizedBox(
                          width: 3.w,
                        ),
                        const Text('Edit Profile'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Logout',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.power_settings_new_outlined,
                          color: Color.fromARGB(255, 197, 60, 50),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        const Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value == 'Edit Profile') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else if (value == 'Logout') {
                  _showPopupDialog(context);
                }
              });
            },
            icon: const Icon(Ionicons.ellipsis_vertical_outline,
                color: Colors.black),
          ),
        ],
        elevation: 0,
        bottom:  const BottomBorderWidget()
      ),

      // bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
      body: Column(
        children: [
          // profile start
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 30.h,
            width: 100.w,
           
            child: Center(
              child: GestureDetector(
                onDoubleTap: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Container(
                  height: 20.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 80, 80, 80).withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box<ProfileDetails>('_profileBoxName')
                          .listenable(),
                      builder: (context, box, child) {
                        final profileFunctions = ProfileFunctions();
                        final List<ProfileDetails> profileDetailsList =
                            profileFunctions.getAllProfileDetails();
                          
                        if (profileDetailsList.isNotEmpty) {
                          final ProfileDetails profileDetails =
                              profileDetailsList.first;
                          
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                profileDetails.name,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                                Text(
                                profileDetails.email,
                                style: const TextStyle(
                                    color: Colors.black26, fontSize: 15),
                              ),
                                  ],
                                ),
                                 SizedBox(width: 10.w),
                              Container(
                                  width: 100,
                                height: 100,
                                 decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: profileDetails.profilePicturePath != null
                                      ? DecorationImage(
                                          image: FileImage(
                                            File(profileDetails.profilePicturePath!),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : const DecorationImage(
                                          image:
                                              AssetImage('images/profile.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ],
                                        )
                              ),
                               
                               
                            ],
                          );
                        }else {
                        return const SizedBox.shrink();
                      }
                    
                      }),
                ),
              ),
            ),
          ),
          // profile end
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              child: NotificationPage(),
                              childCurrent: this));
                    },
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child: Icon(Icons.notifications_none,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            child: CustomizationPage(),
                            childCurrent: this)),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child: Icon(Ionicons.color_palette_outline,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text('Customization', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child:
                              Icon(Icons.backup_outlined, color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text('Backup', style: TextStyle(fontSize: 17))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child: Icon(Icons.restore, color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text('Restore', style: TextStyle(fontSize: 17))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child: Icon(Icons.feedback_outlined,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text('Feedback', style: TextStyle(fontSize: 17))
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _showPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Logout Confirmation',
          style: TextStyle(
            fontSize: 27,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/onboarding');
            },
          ),
        ],
      );
    },
  );
}
