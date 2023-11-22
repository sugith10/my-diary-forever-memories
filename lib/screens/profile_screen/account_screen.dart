
import 'package:diary/screens/auth_screen/welcome_screen.dart';
import 'package:diary/screens/profile_screen/notifications_screen.dart';
import 'package:diary/screens/profile_screen/customization_screen.dart';
import 'package:diary/screens/profile_screen/edit_profile_screen.dart';
import 'package:diary/screens/profile_screen/widget/profile_card.dart';
import 'package:diary/screens/profile_screen/widget/account_screen_item.dart';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:diary/util/profile_screen_functions.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';


class AccountScreen extends StatelessWidget {
   AccountScreen({Key? key});
   final ProfileScreenFunctions profileFunctions = ProfileScreenFunctions();

  

  @override
  Widget build(BuildContext context) {
    String greetingTitle = profileFunctions.getGreeting();

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
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              child: const NotificationPage(),
                              childCurrent: this));
                    },
                    child: 
                    const ProfileOptions(item: 'Notifications', icon: Icons.notifications_none,)
                    ,
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            child: const CustomizationPage(),
                            childCurrent: this)),
                    child: const ProfileOptions(item: 'Customization', icon: Ionicons.color_palette_outline,)
                    
                    
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const InkWell(
                    child: ProfileOptions(item: 'Backup', icon: Icons.backup_outlined,)
                    
                  
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const InkWell(
                    child: ProfileOptions(item: 'Restore', icon: Icons.restore,)
                    
                  
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await profileFunctions.launchEmail();
                    },
                    child: const ProfileOptions(item: 'Feedback', icon: Icons.feedback_outlined,)
                    
                   
                  ),
                   SizedBox(
                    height: 1.2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                   InkWell(
                    onTap: () async {
                      await profileFunctions.launchPrivacyPolicy();
                    },
                    child: const ProfileOptions(item: 'Privacy Policy', icon: Ionicons.newspaper_outline,)
                    
                   
                  ),
                  const Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomePage()));
            },
          ),
        ],
      );
    },
  );
}

}

