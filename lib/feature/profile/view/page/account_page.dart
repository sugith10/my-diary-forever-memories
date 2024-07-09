import 'package:diary/core/route/page_transition/right_to_left.dart';
import 'package:diary/view/util/account_screen_functions.dart';
import 'package:diary/core/util/asset_path/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../view/page/account_page/widget/profile_card.dart';
import '../../../../view/page/archive_page/archive_page.dart';
import '../../../customization/view/page/customization_page.dart';
import '../../../../view/page/account_page/widget/account_page_app_bar.dart';
import '../../../../view/page/account_page/widget/account_screen_content_divider.dart';
import '../widget/profile_options_widget.dart';
import '../../../../view/page/account_page/widget/app_info.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String greetingTitle = ProfileScreenFunctions().getGreeting();

    return Scaffold(
      appBar: AccountPageAppBar(greetingTitle: greetingTitle),
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
                    icon: IconlyLight.unlock,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () => Navigator.of(context)
                        .push(rightToLeft(const CustomizationPage())),
                    item:  "Customization",
                    icon: null,
                    svg: AppSvg.darkMode,
                  ),
                  const ContentDivider(),
                  // backup
                  // ProfileOptions(
                  //   function: () async {
                  //     // await DbFunctions().backupDiaryEntries(context);
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
                    icon:IconlyLight.chat,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () {
                      ProfileScreenFunctions().launchPrivacyPolicy();
                    },
                    item: 'Privacy Policy',
                    icon: IconlyLight.paper,
                  ),
                  const ContentDivider(),
                  ProfileOptions(
                    function: () {
                      ProfileScreenFunctions().launchTermsConditions();
                    },
                    item: 'Terms & Conditions',
                    icon: IconlyLight.paper,
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
