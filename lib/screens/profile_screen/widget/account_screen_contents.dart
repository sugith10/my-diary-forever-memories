// import 'package:diary/screens/profile_screen/customization_screen.dart';
// import 'package:diary/screens/profile_screen/notifications_screen.dart';
// import 'package:diary/screens/profile_screen/widget/profile_options.dart';
// import 'package:diary/util/profile_screen_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:sizer/sizer.dart';

// class AccountScreenContents extends StatelessWidget {
//   AccountScreenContents({super.key});

//   final ProfileScreenFunctions profileFunctions = ProfileScreenFunctions();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 PageTransition(
//                     type: PageTransitionType.rightToLeftJoined,
//                     child: const NotificationPage(),
//                     childCurrent: this));
//           },
//           child: const ProfileOptions(
//             item: 'Notifications',
//             icon: Icons.notifications_none,
//           ),
//         ),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const Divider(),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         InkWell(
//             onTap: () => Navigator.push(
//                 context,
//                 PageTransition(
//                     type: PageTransitionType.rightToLeftJoined,
//                     child: const CustomizationPage(),
//                     childCurrent: this)),
//             child: const ProfileOptions(
//               item: 'Customization',
//               icon: Ionicons.color_palette_outline,
//             )),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const Divider(),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const InkWell(
//             child: ProfileOptions(
//           item: 'Backup',
//           icon: Icons.backup_outlined,
//         )),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const Divider(),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const InkWell(
//             child: ProfileOptions(
//           item: 'Restore',
//           icon: Icons.restore,
//         )),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const Divider(),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         InkWell(
//             onTap: () async {
//               await profileFunctions.launchEmail();
//             },
//             child: const ProfileOptions(
//               item: 'Feedback',
//               icon: Icons.feedback_outlined,
//             )),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         const Divider(),
//         SizedBox(
//           height: 1.2.h,
//         ),
//         InkWell(
//             onTap: () async {
//               await profileFunctions.launchPrivacyPolicy();
//             },
//             child: const ProfileOptions(
//               item: 'Privacy Policy',
//               icon: Ionicons.newspaper_outline,
//             )),
//         const Spacer()
//       ],
//     );
//   }
// }
