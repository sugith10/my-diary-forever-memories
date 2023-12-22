import 'package:diary/presentation/screens/customization_screen/customization_screen.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_divider.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_item.dart';
import 'package:diary/presentation/screens/account_screen/widget/profile_card.dart';
import 'package:diary/presentation/screens/archive_screen/archive_page.dart';
import 'package:diary/presentation/screens/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/util/account_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:sizer/sizer.dart';

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
                  ProfileScreenFunctions().showPopupDialog(context);
                },
                icon: const Icon(
                  Icons.power_settings_new_outlined,
                  color: Color.fromARGB(255, 197, 60, 50),
                )),
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
                        child: const ArchivePage(),
                        childCurrent: this,
                      ),
                    ),
                    item: 'Archived',
                    icon: Icons.archive_outlined,
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
                  //backup
                  // ProfileOptions(
                  //   function: () async {
                  //     await DbFunctions().backupDiaryEntries(context);
                  //   },
                  //   item: 'Backup',
                  //   icon: Icons.backup_outlined,
                  // ),
                  // const ContentDivider(),
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
                  ProfileOptions(
                    function: () async {
                      await ProfileScreenFunctions().launchTermsConditions();
                    },
                    item: 'Terms & Conditions',
                    icon: Ionicons.newspaper_outline,
                  ),
                  const ContentDivider(),
                  const SizedBox(height: 20),
                   const Text(
                    'Made with 💙 in India',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('© 2023 DayProduction® v1.1.0', style: TextStyle(fontSize: 15)),
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
