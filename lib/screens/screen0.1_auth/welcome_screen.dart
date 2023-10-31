import 'package:animate_do/animate_do.dart';
import 'package:diary/screens/screen0.1_auth/login_screen.dart';
import 'package:diary/screens/screen0.1_auth/signin_screen.dart';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
            child: Container(
          color: Colors.white,
          child: Column(
            children: [
              FadeInDown(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 800),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/first-img.png',
                      width: 100.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.6.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              delay: const Duration(milliseconds: 700),
                              duration: const Duration(milliseconds: 800),
                              child: Text(
                                'Industrial 4.0 Task Manager App',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.sp, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            FadeInUp(
                              delay: const Duration(milliseconds: 900),
                              duration: const Duration(milliseconds: 1000),
                              child: Text(
                                'Lorem ipsum dolor sit amet ameer consectetur adipiscing elit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 1100),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Satoshi'),
                                  backgroundColor: Color(0xFF835DF1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16)),
                              child: FadeInUp(
                                  delay: const Duration(milliseconds: 1100),
                                  duration: const Duration(milliseconds: 1200),
                                  child: Text('Log In')),
                            ),
                          )
                        ],
                      ),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1100),
                      duration: const Duration(milliseconds: 1200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInPage()));
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Color(0xFF835DF1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}