import 'package:diary/core/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DiaryCardView extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryCardView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color.fromARGB(255, 9, 9, 9),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light ?Colors.grey.withOpacity(0.1) : Colors.transparent,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  entry.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.sp),
          Text(
            entry.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
               color: Theme.of(context).brightness == Brightness.light ? const Color.fromRGBO(107, 107, 107, 1) : const Color.fromRGBO(190, 192, 192, 50),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 5.sp),
        ],
      ),
    );
  }
}
