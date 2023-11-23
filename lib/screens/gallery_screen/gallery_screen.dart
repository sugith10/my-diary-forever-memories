import 'dart:io';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/individual_diary_screen/individual_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<DiaryEntry>('_boxName');
    final imageCount =
        box.values.where((entry) => entry.imagePath != null).length;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  const AppbarTitleWidget(text: 'Gallery'),
        elevation: 0,
        bottom: const BottomBorderWidget()
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
       
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0, 
                crossAxisSpacing: 6.0, 
                itemCount: imageCount,
                itemBuilder: (context, index) {
                  final imageEntries =
                      box.values.where((entry) => entry.imagePath != null);
                  final data = imageEntries.elementAt(index);
                  return DiaryGalleryEntryCard(data);
                },
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(1);
                  // return StaggeredTile.count((index % 3 == 0) ? 3 : 1, (index % 3 == 0) ? 2 : 1, );
                  // return StaggeredTile.count(1, 2); 
                },
              );
            },
          ),
        
      ),
    );
  }
}

class DiaryGalleryEntryCard extends StatelessWidget {
  final DiaryEntry entry;

  DiaryGalleryEntryCard(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryDetailPage(
              entry: entry,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(entry.imagePath!),
          // fit: BoxFit.cover,
          // height:double.infinity, // Adjust the height as needed
          // width: double.infinity, // Adjust the width as needed
        ),
      ),
    );
  }
}
