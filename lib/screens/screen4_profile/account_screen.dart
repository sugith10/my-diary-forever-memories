import 'package:diary/screens/screen4_profile/item_1_notifications.dart';
import 'package:diary/screens/screen4_profile/item_2_customization.dart';
import 'package:diary/screens/screen4_profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

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
        title: Text(greetingTitle, style: const TextStyle(color: Colors.black)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
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

      //bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 30.h,
            width: 100.w,
            // color: Colors.amber,
            child: const Column(
              children: [
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'images/profile.png',
                  ),
                  backgroundColor: Color(0xFFF1F5FF),
                  maxRadius: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'user email',
                  style: TextStyle(color: Colors.black26, fontSize: 15),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Spacer(),
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
