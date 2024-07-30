
import 'package:diary/feature/archive/model/archive_diary_model/archive_diary_model.dart';
import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../page/individual_archive_page.dart';

class ArchiveCardView extends StatelessWidget {
  final ArchiveDiaryModel archiveDiaryModel;
  const ArchiveCardView({required this.archiveDiaryModel, super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(archiveDiaryModel.date);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
         bottomToTop(IndividualArchive(
              archiveDiaryModel: archiveDiaryModel,
            ))
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
         color: Theme.of(context).brightness == Brightness.light
            ? AppLightColor.instance.card
            : AppDarkColor.instance.card,
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
                    archiveDiaryModel.title,
                    style: TextStyle(
                      fontSize: 15.sh,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.sh),
            Text(
              archiveDiaryModel.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sh,
                color: Theme.of(context).brightness == Brightness.light ? const Color.fromRGBO(107, 107, 107, 1) : const Color.fromRGBO(190, 192, 192, 50),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.sh),
          ],
        ),
      ),
    );
  }
}
