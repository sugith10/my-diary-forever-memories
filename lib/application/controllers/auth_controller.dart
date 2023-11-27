import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends StatelessWidget {
  const AuthController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user is logged in
        if (snapshot.hasData && snapshot.data != null) {
          return MainScreen();
        }

        //user not logged in
        else {
          return const LoginPage();
        }
      },
    ));
  }
}
