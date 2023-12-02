import 'package:diary/presentation/screens/account_screen/customization_screen/customization_screen.dart';
import 'package:diary/presentation/screens/account_screen/notifications_sceen/notifications_screen.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_divider.dart';
import 'package:diary/presentation/screens/account_screen/widget/account_screen_content_item.dart';
import 'package:diary/presentation/util/account_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class AccountScreenContents extends StatelessWidget {
  AccountScreenContents({super.key});

  final ProfileScreenFunctions profileFunctions = ProfileScreenFunctions();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(
        builder: (context) {
          // Use the obtained context to access the theme
          final theme = Theme.of(context);

          return Container(
             decoration: BoxDecoration(
              color: theme.colorScheme.background, // Use the background color from the theme
              borderRadius: BorderRadius.circular(10.0),
            ),
          
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                 mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 1.2.h),
                   const ContentDivider(),
                  SizedBox(height: 1.2.h),
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
                  SizedBox(height: 1.2.h),
                    const ContentDivider(),
                  SizedBox(height: 1.2.h),
                  const InkWell(
                    child: ProfileOptions(
                      item: 'Backup',
                      icon: Icons.backup_outlined,
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                   const ContentDivider(),
                  SizedBox(height: 1.2.h),
                  const InkWell(
                    child: ProfileOptions(
                      item: 'Restore',
                      icon: Icons.restore,
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                   const ContentDivider(),
                  SizedBox(height: 1.2.h),
                  InkWell(
                    onTap: () async {
                      await ProfileScreenFunctions().launchEmail();
                    },
                    child: const ProfileOptions(
                      item: 'Feedback',
                      icon: Icons.feedback_outlined,
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                   const ContentDivider(),
                  SizedBox(height: 1.2.h),
                  InkWell(
                    onTap: () async {
                      await ProfileScreenFunctions().launchPrivacyPolicy();
                    },
                    child: const ProfileOptions(
                      item: 'Privacy Policy',
                      icon: Ionicons.newspaper_outline,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
