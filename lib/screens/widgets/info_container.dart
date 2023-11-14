import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String description;

  InfoContainer({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 30.h,
      width: 100.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                description,
                style: TextStyle(color: Colors.black54, fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
