import 'package:animate_do/animate_do.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/screen0.1_auth/login_screen.dart';
import 'package:diary/screens/screen0.1_auth/welcome_screen.dart';
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(color: Colors.white),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomePage()));
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 900),
                          child: Text(
                            'Welcome to the club!',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            'Excited to have you as',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: Text(
                            'Part of our community...',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // Row(
                    //   children: [
                    //      InputField(
                    //   labelText: 'Email',
                    //   focusNode: focusNodeEmail,
                    //   isFocused: isFocusedEmail,
                    //   controller: emailController,
                    // ),
                    
                    //   ],
                    // ),
                    InputField(
                      labelText: 'Email',
                      focusNode: focusNodeEmail,
                      isFocused: isFocusedEmail,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InputField(
                      labelText: 'Password',
                      focusNode: focusNodePassword,
                      isFocused: isFocusedPassword,
                      controller: passwordController,
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
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Satoshi',
                                ),
                                backgroundColor: Color(0xFF835DF1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: FadeInUp(
                                delay: const Duration(milliseconds: 700),
                                duration: const Duration(milliseconds: 800),
                                child: Text('Sign Up'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 900),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF835DF1),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            ),
                           
                      ],
                    ),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final bool isFocused;
  final TextEditingController controller;

  InputField({
    required this.labelText,
    required this.focusNode,
    required this.isFocused,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.8.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .3.h),
            decoration: BoxDecoration(
              color: isFocused ? Colors.white : Color(0xFFF1F0F5),
              border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (isFocused)
                  BoxShadow(
                    color: Color(0xFF835DF1).withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
              ],
            ),
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: labelText,
              ),
              focusNode: focusNode,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
