
import 'package:diary/screens/profile_screen/notifications_screen.dart';
import 'package:diary/screens/profile_screen/customization_screen.dart';
import 'package:diary/screens/profile_screen/edit_profile_screen.dart';
import 'package:diary/screens/profile_screen/widget/account_screen_contents.dart';
import 'package:diary/screens/profile_screen/widget/profile_card.dart';
import 'package:diary/screens/profile_screen/widget/profile_options.dart';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:diary/util/profile_screen_functions.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({Key? key});
  

  String _getGreeting() {
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
    String greetingTitle = _getGreeting();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitleWidget(
            text: greetingTitle,
          ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
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
          bottom: const BottomBorderWidget()),
      body: Column(
        children: [
          // profile start
         const ProfileCard(),          // profile end
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: AccountScreenContents()
            )
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
