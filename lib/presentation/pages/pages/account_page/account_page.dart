import 'package:diary/presentation/navigation/screen_transitions/right_to_left.dart';
import 'package:diary/presentation/pages/pages/customization_page/customization_page.dart';
import 'package:diary/presentation/pages/pages/account_page/widget/account_screen_content_divider.dart';
import 'package:diary/presentation/pages/pages/account_page/widget/account_screen_content_item.dart';
import 'package:diary/presentation/pages/pages/account_page/widget/profile_card.dart';
import 'package:diary/presentation/pages/pages/archive_page/archive_page.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_titlestyle_common.dart';
import 'package:diary/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/pages/util/account_screen_functions.dart';
import 'package:diary/presentation/pages/util/get_theme_type.dart';
import 'package:diary/presentation/utils/assets/app_svg.dart';
import 'package:flutter/material.dart';

import 'widget/app_info.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                // ProfileScreenFunctions().showPopupDialog(context);
              },
              icon: const Icon(
                Icons.power_settings_new_outlined,
                color: Color.fromARGB(255, 197, 60, 50),
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
                    function: () => Navigator.of(context)
                        .push(rightToLeft(const ArchivePage())),
                    item: 'Archived',
                    icon: AppSvg.archive,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () => Navigator.of(context)
                        .push(rightToLeft(const CustomizationPage())),
                    item: 'Customization',
                    icon: isDark(context) ?  AppSvg.darkMode :  AppSvg.lightMode,
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
                    function: () {
                      ProfileScreenFunctions().launchEmail();
                    },
                    item: 'Feedback',
                    icon: AppSvg.feedback,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () {
                      ProfileScreenFunctions().launchPrivacyPolicy();
                    },
                    item: 'Privacy Policy',
                    icon: AppSvg.terms,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () {
                      ProfileScreenFunctions().launchTermsConditions();
                    },
                    item: 'Terms & Conditions',
                    icon: AppSvg.terms,
                  ),
                  const ContentDivider(),
                  const SizedBox(height: 20),
                  const AppInfoWidget(),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
