// import 'package:flutter/material.dart';

// class LogoutConfirmationDialog extends StatelessWidget {
//   const LogoutConfirmationDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text(
//         'Logout Confirmation',
//         style: TextStyle(
//           fontSize: 27,
//         ),
//       ),
//       content: const Text(
//         'Are you sure you want to log out?',
//         style: TextStyle(fontSize: 17),
//       ),
//       actions: [
//         TextButton(
//           child: const Text('Cancel', style: TextStyle(color: Colors.black)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: const Text('Logout', style: TextStyle(color: Colors.red)),
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/onboarding');
//           },
//         ),
//       ],
//     );
//   }
// }
