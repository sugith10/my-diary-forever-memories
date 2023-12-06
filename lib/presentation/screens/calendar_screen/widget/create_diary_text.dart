import 'package:diary/presentation/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateDiaryText extends StatelessWidget {
  const CreateDiaryText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start writing about your day...',
            style: TextStyle(
                fontSize: 20,
                
              ),
          ),
          SizedBox(
            height: 0.1.h,
          ),
          Text(
            'Click this text to create your personal diary',
            style: TextStyle(
                color: AppColor.secondary.color,
                fontWeight: FontWeight.w400,
                fontSize: 12.5,
              ),
          ),
        ],
      ),
    );
  }
}
