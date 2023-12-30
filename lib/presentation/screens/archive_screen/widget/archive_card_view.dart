import 'package:diary/models/archive_db_model.dart';
import 'package:diary/presentation/screen_transition/bottom_to_top.dart';
import 'package:diary/presentation/screens/archive_screen/individual_archive_page/individual_archive_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ArchiveCardView extends StatelessWidget {
  final ArchiveDiary archiveDiary;
  const ArchiveCardView({required this.archiveDiary, super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(archiveDiary.date);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
         bottomToTop(IndividualArchive(
              archiveDiary: archiveDiary,
            ))
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 9, 9, 9),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                formattedDate,
                style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.black54 : Colors.white30),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    archiveDiary.title,
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
              archiveDiary.content,
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
      ),
    );
  }
}
