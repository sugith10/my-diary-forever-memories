import 'package:animate_do/animate_do.dart';
import 'package:diary/presentation/screens/login_signin_screen/login_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/signin_screen.dart';
import 'package:diary/presentation/screens/login_signin_screen/widget/navigation_elevated_button.dart';
import 'package:diary/presentation/util/get_colors.dart';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FadeInDown(
              delay: const Duration(milliseconds: 800),
              duration: const Duration(milliseconds: 800),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Theme.of(context).brightness == Brightness.light ? Image.asset(
                    'assets/images/forever_memories_logo/forever_memories_logo_black.png',
                    width: 100.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ) : Image.asset(
                    'assets/images/forever_memories_logo/forever_memories_logo_white.png',
                    width: 100.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ) ,
                ),
              ),
            ),
            Container(
             
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
                          Center(
                            child: FadeInUp(
                              delay: const Duration(milliseconds: 700),
                              duration: const Duration(milliseconds: 800),
                              child: Text(
                                'Forever Memories',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: GetColors().getFontColor(context),
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Satoshi"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 900),
                            duration: const Duration(milliseconds: 1000),
                            child: Text(
                              'In the book of your heart, every chapter is a memory to rember forever.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: GetColors().getFontColor (context),
                              ),
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
                          child: NavigationElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                            buttonText: 'Log In',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
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
      ),
    );
  }
}
