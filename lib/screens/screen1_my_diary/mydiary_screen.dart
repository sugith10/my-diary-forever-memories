import 'dart:developer';

import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/provider_mainscreen.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/create_page.dart';
import 'package:diary/screens/screen1_my_diary/search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MyDiaryScreen extends StatelessWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Diary', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySearchAppBar()),
                );
              },
              icon: Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Ionicons.bookmarks_outline, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Ionicons.ellipsis_vertical_outline, color: Colors.black),
            ),
          ],
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
        ),
        body:  ValueListenableBuilder(
      valueListenable: diaryEntriesNotifier,
      builder: (BuildContext ctx, List<DiaryEntry> diaryEntry, Widget? child) {
      
        log('DiaryEntryList: Rebuilding with ${diaryEntry.length} entries'); // Add this line
        return Consumer<MainScreenProvider>(
          builder: (context, value, child) => 
           FutureBuilder(
            future: value.getAllDiary(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return  ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print('DiaryEntryList: Building item $index'); // Add this line
                return DiaryEntryCard(diaryEntry[index]);
              },
                     );
              }
               else{
                return Center(child: Text(snapshot.error.toString()),);
               }
            },
           
            
           ),
        );
      },
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final changer = Provider.of<Changer>(context, listen: false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePage(changer: changer),
              ),
            );
          },
          child: Icon(Icons.create_outlined),
          backgroundColor: Color.fromARGB(255, 150, 186, 222),
        ),
      ),
    );
  }
}

// class DiaryEntryList extends StatelessWidget {
//   const DiaryEntryList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     getAllDiary();
//     return
//   }
// }


class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;

  DiaryEntryCard(this.entry);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Container(
        padding: EdgeInsets.all(16.0),
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
            Text(
              entry.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              entry.content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('d MMMM, y').format(entry.date),
                  style: TextStyle(
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
    );
  }
}
