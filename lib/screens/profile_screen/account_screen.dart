import 'package:diary/screens/auth_screen/welcome_screen.dart';
import 'package:diary/screens/profile_screen/notifications_screen.dart';
import 'package:diary/screens/profile_screen/customization_screen.dart';
import 'package:diary/screens/profile_screen/edit_profile_screen.dart';
import 'package:diary/screens/profile_screen/widget/account_screen_contents.dart';
import 'package:diary/screens/profile_screen/widget/profile_card.dart';
import 'package:diary/screens/profile_screen/widget/account_screen_content_item.dart';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:diary/util/profile_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    String greetingTitle = ProfileScreenFunctions().getGreeting();

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
                    ProfileScreenFunctions().showPopupDialog(context);
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
          const ProfileCard(),
          Expanded(
            child: AccountScreenContents(),
          )
        ],
      ),
    );
  }

  }


 