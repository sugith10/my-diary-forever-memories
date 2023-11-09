import 'dart:io';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/screen1_my_diary/mydiary_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class DiaryDetailPage extends StatefulWidget {
  final DiaryEntry entry;

  DiaryDetailPage({required this.entry, Key? key}) : super(key: key);

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  void _showOriginalImage(BuildContext context) {
    if (widget.entry.imagePath != null) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Image.file(
              File(widget.entry.imagePath!),
              fit: BoxFit.contain,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(1, 0, 0, 5),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'Edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline_rounded),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value == 'Edit') {
                  
                   
                  } else if (value == 'Delete') {
                    _showDeleteConfirmationDialog(context, widget.entry);
                  }
                });
              },
              icon: const Icon(Ionicons.ellipsis_vertical_outline,
                  color: Colors.black),
            )
          ],
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    widget.entry.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    DateFormat('d MMMM,y').format(widget.entry.date),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.entry.imagePath != null)
              GestureDetector(
                onTap: () {
                  _showOriginalImage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(widget.entry.imagePath!),
                      fit: BoxFit.cover,
                      height: 500,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.entry.content,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (widget.entry.id != null) {
              DbFunctions().deleteDiary(widget.entry.id!);
            }
            Navigator.pop(context);
          },
          backgroundColor: Colors.red, // Twitter red color
          icon: Icon(Icons.delete, color: Colors.white),
          label: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}

void _showDeleteConfirmationDialog(BuildContext context, DiaryEntry entry) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Delete Confirmation',
          style: TextStyle(
            fontSize: 27,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this?',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              if (entry.id != null) {
                DbFunctions().deleteDiary(entry.id!);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDiaryScreen()));
                // //asdkfjhakjhnfjkhnskdhjnfhasdkhjfjhakjsdjfhdsfhnbnvfbnsvnbjandhnfdsbnbn 
                // Navigator.pushAndRemoveUntil(context, /main, (route) => false)
              Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => MainScreen()),
  ModalRoute.withName('/main'),
);


                
              }
             
            },
          ),
        ],
      );
    },
  );
}

