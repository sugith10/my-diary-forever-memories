import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen5_create/emoji_picker.dart';
import 'package:diary/screens/screen5_create/provider_create.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';


class CreatePage extends StatefulWidget {
  late  DateTime selectedDate;

   CreatePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
 
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
            icon: Icon(Ionicons.chevron_back_outline, color: Colors.black, size: 25),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  final title = titleController.text;
                  final content = contentController.text;
                  if (title.isNotEmpty) {
                    final entry = DiaryEntry(
                      date: widget.selectedDate,
                      title: title,
                      content: content,
                    );

                    HiveOperations().addDiaryEntry(entry);

                    HiveOperations().getDiaryEntries().then((entries) {
                      print("All Diary Entries:");
                      entries.forEach((entry) {
                        print("Date: ${entry.date}");
                        print("Title: ${entry.title}");
                        print("Content: ${entry.content}");
                      });
                    });
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
      initialDate: widget.selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2029),
    );
    if (pickedDate != null) {
      setState(() {
        widget.selectedDate = pickedDate;
      });
    }
  },       
                    child: Row(
                      children: [
                        Text(
                          DateFormat('d MMMM,y').format(widget.selectedDate),
                          style: TextStyle(color: Colors.black),
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
      ),
    );
  }
}
