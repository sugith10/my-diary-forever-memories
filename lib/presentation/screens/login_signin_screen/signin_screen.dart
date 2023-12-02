import 'package:animate_do/animate_do.dart';
import 'package:diary/presentation/screens/login_signin_screen/widget/input_field.dart';
import 'package:diary/presentation/screens/login_signin_screen/widget/navigation_text_button.dart';
import 'package:diary/presentation/screens/login_signin_screen/widget/welcome_text_widget.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/login_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/welcome_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/widget/navigation_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  bool isFocusedEmail = false;
  bool isFocusedPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    focusNodeEmail.addListener(() {
      setState(() {
        isFocusedEmail = focusNodeEmail.hasFocus;
      });
    });
    focusNodePassword.addListener(() {
      setState(() {
        isFocusedPassword = focusNodePassword.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: 100.h,
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 900),
                        duration: const Duration(milliseconds: 1000),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          },
                          icon: Icon(
                            IconlyBroken.arrow_left,
                            size: 3.6.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const WelcomeTextWidget(
                        firstLine: 'Welcome to the club!',
                        secondLine: 'Excited to have you as',
                        thirdLine: 'Part of our community...',
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      InputField(
                        labelText: 'Email',
                        focusNode: focusNodeEmail,
                        isFocused: isFocusedEmail,
                        controller: emailController,
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InputField(
                        labelText: 'Password',
                        focusNode: focusNodePassword,
                        isFocused: isFocusedPassword,
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 700),
                        child: Row(
                          children: [
                            Expanded(
                              child: NavigationElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()));
                                },
                                buttonText: 'Sign Up',
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 900),
                        child: NavigationTextButtonRow(
                          leadingText: 'Have an account?',
                          buttonText: 'Login',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
