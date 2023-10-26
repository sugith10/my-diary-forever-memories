import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class CreatePage extends StatefulWidget {
  final DateTime selectedDate; 

  const CreatePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState(selectedDate);
}

class _CreatePageState extends State<CreatePage> {
  // int _selectedIndex = 0;
  final DateTime? selectedDate;  
  _CreatePageState(this.selectedDate);
   final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
               
              Navigator.pop(context);
            },
            icon: Icon(Ionicons.chevron_back_outline,
                color: Colors.black, size: 25),
          ),
          actions: [
            Center(
                child: TextButton(
                    onPressed: () {
                      final entry = DiaryEntry(
      date: widget.selectedDate,
      title: titleController.text,
      content: contentController.text,
    );
    HiveOperations().addDiaryEntry(entry);


    // Print all data to the terminal
                      HiveOperations().getDiaryEntries().then((entries) {
                        print("All Diary Entries:");
                        entries.forEach((entry) {
                          print("Date: ${entry.date}");
                          print("Title: ${entry.title}");
                          print("Content: ${entry.content}");
                        });
                      });
              Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
            ),
            SizedBox(
              width: 20,
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
        body: Container(
           margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    DateFormat('d MMMM,y').format(selectedDate!),
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  CircleAvatar(
                    child: Icon(Ionicons.happy_outline),
                  ),
                ],
              ),
              TextField(
                 controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 28),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
                cursorHeight: 28,
                textAlignVertical: TextAlignVertical.center,
              ),
              SizedBox(height: 5),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Start typing here',
                  hintStyle: TextStyle(fontSize: 18),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.red,
                cursorHeight: 13,
                textAlignVertical: TextAlignVertical.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
