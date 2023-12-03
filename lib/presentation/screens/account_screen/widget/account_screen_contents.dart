import 'package:diary/application/controllers/hive_diary_entry_db_ops.dart';
import 'package:diary/presentation/screens/account_screen/customization_screen/customization_screen.dart';
import 'package:diary/presentation/screens/account_screen/notifications_sceen/notifications_screen.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_divider.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_item.dart';
import 'package:diary/presentation/util/account_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';


class AccountScreenContents extends StatelessWidget {
  AccountScreenContents({super.key});

  final ProfileScreenFunctions profileFunctions = ProfileScreenFunctions();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(
        builder: (context) {
          // Use the obtained context to access the theme
          // final theme = Theme.of(context);

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
               
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        child: const NotificationPage(),
                        childCurrent: this,
                      ),
                    );
                  },
                  child: const ProfileOptions(
                    item: 'Notifications',
                    icon: Icons.notifications_none,
                  ),
                ),
                SizedBox(height: 10),
                 const ContentDivider(),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      child: const CustomizationPage(),
                      childCurrent: this,
                    ),
                  ),
                  child: const ProfileOptions(
                    item: 'Customization',
                    icon: Ionicons.color_palette_outline,
                  ),
                ),
                SizedBox(height: 10),
                  const ContentDivider(),
                SizedBox(height: 10),
                InkWell(
                  onTap: ()async{
                    await DbFunctions().backupDiaryEntries(context);
                    print('backup');
                  },
                  child: const ProfileOptions( 
                    item: 'Backup',
                    icon: Icons.backup_outlined,
                  ),
                ),
                SizedBox(height: 10),
                 const ContentDivider(),
                SizedBox(height: 10),
                const InkWell(
                  child: ProfileOptions(
                    item: 'Restore',
                    icon: Icons.restore,
                  ),
                ),
                SizedBox(height: 10),
                 const ContentDivider(),
                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    await ProfileScreenFunctions().launchEmail();
                  },
                  child: const ProfileOptions(
                    item: 'Feedback',
                    icon: Icons.feedback_outlined,
                  ),
                ),
                SizedBox(height: 10),
                 const ContentDivider(),
                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    await ProfileScreenFunctions().launchPrivacyPolicy();
                  },
                  child: const ProfileOptions(
                    item: 'Privacy Policy',
                    icon: Ionicons.newspaper_outline,
                  ),
                ),
                SizedBox(height: 20),
                const Text('© 2023 DayProduction® v1.0.0'),
                 const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
