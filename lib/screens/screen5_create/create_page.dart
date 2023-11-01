import 'dart:developer';

import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/provider_mainscreen.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  // late  DateTime selectedDate;
  final Changer changer; // Inject Changer here

  CreatePage({Key? key, required this.changer}) : super(key: key);

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                onPressed: () async {
                  final title = titleController.text;
                  final content = contentController.text;


                  if (title.isNotEmpty) {
                    final entry = DiaryEntry(
                      date: changer.selectedDate,
                      title: title,
                      content: content,
                    );
                  await  DbFunctions().addDiaryEntry(entry).then((value) => log("function completed$value"));
                    
                   
                    
                     // Get the HiveOperations instance
                  // final hiveOperations = Provider.of<HiveOperations>(context, listen: false);

                  // Call the refreshEventdata method
                  // await hiveOperations.refreshEventdata();

                    // if (!box.isEmpty) {
                      
                    //   print("All Diary Entries:");
                    //   final entries = box.values.toList() as List<DiaryEntry>;
                    //   for (var entry in entries) {
                    //     print("Date: ${entry.date}");
                    //     print("Title: ${entry.title}");
                    //     print("Content: ${entry.content}");
                    //   }
                    // } else {
                    //   print("No diary entries found!");
                    // }
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
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
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: changer.selectedDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2029),
                      );
                      if (pickedDate != null) {
                        changer.selectDate(pickedDate);
                        print(changer.selectedDate);
                        var selectedate = changer.selectedDate;
                      }
                    },
                    child: Row(
                      children: [
                        Consumer<Changer>(
                          builder: (context, changer, child) {
                            return Text(
                              DateFormat('d MMMM,y')
                                  .format(changer.selectedDate),
                              style: TextStyle(color: Colors.black),
                            );
                          },
                        ),
                        Icon(
                          Ionicons.caret_down_outline,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return EmojiPicker(
                            onEmojiSelected: (selectedEmoji) {},
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(Ionicons.happy_outline),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: ' Title',
                  hintStyle: TextStyle(fontSize: 28),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.green[900],
                cursorHeight: 28,
                style: TextStyle(fontSize: 28),
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 5),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: '  Start typing here',
                  hintStyle: TextStyle(fontSize: 18),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.red[900],
                cursorHeight: 18,
                style: TextStyle(fontSize: 18),
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
           showUnselectedLabels: false,
        showSelectedLabels: false,
          type: BottomNavigationBarType.fixed, 
          items: [
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.text_outline,
              ),
              label: 'Font'),
              
          BottomNavigationBarItem(
              icon: Icon(Ionicons.happy_outline), label: 'Emoji'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.image_outline), label: 'Gallery'),
              
               BottomNavigationBarItem(
              icon: Icon(Ionicons.color_palette_outline), label: 'Color',)
        ]),
      ),
    );
  }
}
