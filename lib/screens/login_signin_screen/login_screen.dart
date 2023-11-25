import 'package:animate_do/animate_do.dart';
import 'package:diary/screens/login_signin_screen/widget/input_field.dart';
import 'package:diary/screens/login_signin_screen/widget/navigation_text_button.dart';
import 'package:diary/screens/login_signin_screen/widget/social_login.dart';
import 'package:diary/screens/login_signin_screen/widget/welcome_text_widget.dart';
import 'package:diary/screens/main_screen/main_screen.dart';
import 'package:diary/screens/login_signin_screen/signin_screen.dart';
import 'package:diary/screens/login_signin_screen/welcome_screen.dart';
import 'package:diary/screens/login_signin_screen/widget/navigation_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  bool isFocusedEmail = false;
  bool isFocusedPassword = false;

  // sign user in method
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 void signUserIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  } catch (e) {
    print("Error during sign-in: $e");
  }
}


  @override
  void initState() {
    // TODO: implement initState
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
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: 100.h,
              decoration: const BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
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
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const WelcomeTextWidget(
                    firstLine: 'Let\'s Sign You In',
                    secondLine: 'Welcome back.',
                    thirdLine: 'You\'ve been missed!',
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
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  //forgot passworddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
                  FadeInDown(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 800),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 700),
                    child: Row(
                      children: [
                        Expanded(
                          child: NavigationElevatedButton(
                            onPressed: () {
                             signUserIn();
                            },
                            buttonText: 'Log In',
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  //googleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                  SocialLoginDivider(),
                  //google endddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
                  const Spacer(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 900),
                    child: NavigationTextButtonRow(
                      leadingText: 'Don\'t have an account?',
                      buttonText: 'Register',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
