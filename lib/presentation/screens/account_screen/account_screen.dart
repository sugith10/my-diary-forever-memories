import 'package:diary/application/controllers/hive_diary_entry_db_ops.dart';
import 'package:diary/presentation/screens/account_screen/customization_screen/customization_screen.dart';
import 'package:diary/presentation/screens/account_screen/notifications_sceen/notifications_screen.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_divider.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_item.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/screens/account_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:diary/presentation/screens/account_screen/widget/profile_card.dart';
import 'package:diary/presentation/screens/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/util/account_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
  });

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
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : AppColor.showMenuDark.color,
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
              icon: const Icon(
                Ionicons.ellipsis_vertical_outline,
              ),
            ),
          ],
          elevation: 0,
          bottom: const BottomBorderWidget()),
      body: Column(
        children: [
          const ProfileCard(),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  ProfileOptions(
                    function: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        child: const NotificationPage(),
                        childCurrent: this,
                      ),
                    ),
                    item: 'Notifications',
                    icon: Icons.notifications_none,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        child: const CustomizationPage(),
                        childCurrent: this,
                      ),
                    ),
                    item: 'Customization',
                    icon: Ionicons.color_palette_outline,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () async {
                      await DbFunctions().backupDiaryEntries(context);
                    },
                    item: 'Backup',
                    icon: Icons.backup_outlined,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () async {
                      await ProfileScreenFunctions().launchEmail();
                    },
                    item: 'Feedback',
                    icon: Icons.feedback_outlined,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () async {
                      await ProfileScreenFunctions().launchPrivacyPolicy();
                    },
                    item: 'Privacy Policy',
                    icon: Ionicons.newspaper_outline,
                  ),
                  const ContentDivider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Made with 💙 in India',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('© 2023 DayProduction® v1.0.0'),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
