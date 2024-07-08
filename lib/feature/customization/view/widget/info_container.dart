import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String description;

  const InfoContainer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: Center(
        child: Column(
        
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                description,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
