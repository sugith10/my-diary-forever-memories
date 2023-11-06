import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen1_my_diary/diary.dart';
import 'package:diary/screens/screen1_my_diary/mydiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        automaticallyImplyLeading: false,
        title: (const Text(
          'Gallery',
          style: TextStyle(color: Colors.black),
        )),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 0.1,
              ),
            ),
          ),
        ),
      )),
     body: ValueListenableBuilder(
          valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final data = value.values.toList()[index];
                return DiaryGalleryEntryCard(data);
              },
            );
          },
        ),
    );
  }
}

class DiaryGalleryEntryCard extends StatelessWidget {
  final DiaryEntry entry;

  DiaryGalleryEntryCard(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return 
       InkWell(
        onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> DiaryDetailPage(entry: entry,)));
        },
        child: Padding(
          padding:  EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Container(
            padding:  EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),Spacer(),
                     InkWell(child: Icon(Icons.delete), onTap: () {
                        if (entry.id != null) {
    DbFunctions().deleteDiary(entry.id!); // Pass the entry's id to delete
  }
                      
                     },)
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  entry.content,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('d MMMM, y').format(entry.date),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    // You can add additional icons or buttons here if needed
                    // For example, an edit button or a delete button
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}

