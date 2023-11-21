import 'package:diary/screens/color/primary_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateDiaryText extends StatelessWidget {
  const CreateDiaryText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Start writing about your day...',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 31, 31, 31),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  // fontFamily: "Poppins"
                                ),
                              ),
                              SizedBox(height: 0.1.h,),
                              Text(
                                'Click this text to create your personal diary',
                                style: TextStyle(
                                    color: AppColor.secondary.color,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        );
  }
}