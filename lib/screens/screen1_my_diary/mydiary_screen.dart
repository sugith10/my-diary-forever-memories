import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen5_create/create_page.dart';
import 'package:diary/screens/screen1_my_diary/search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  List<DiaryEntry> diaryEntries = []; 

  @override
  void initState() {
    super.initState();
    
    getDiaryEntries();
  }

 
  void getDiaryEntries() {
    HiveOperations().getDiaryEntries().then((entries) {
      setState(() {
        diaryEntries = entries;
      });
    });
  }

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
        body: ListView.builder(
          itemCount: diaryEntries.length,
          itemBuilder: (context, index) {
            return DiaryEntryCard(diaryEntries[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePage(selectedDate: DateTime.now()),
              ),
            );
          },
          child: Icon(Icons.create_outlined),
         backgroundColor: Color(0xFF5B6ABF), 
        ),
      ),
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;

  DiaryEntryCard(this.entry);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(entry.title, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(entry.content),
        trailing: Text(DateFormat('d MMMM, y').format(entry.date)),
      ),
    );
  }
}

