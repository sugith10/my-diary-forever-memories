import 'dart:io';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/screen1_my_diary/edit_screen.dart';
import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class DiaryDetailPage extends StatefulWidget {
  final DiaryEntry entry;

  const DiaryDetailPage({required this.entry, Key? key}) : super(key: key);

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
          leading: const BackButtonWidget(),
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(1, 0, 0, 5),
                  items: <PopupMenuEntry>[
                    
                    PopupMenuItem(
                      value: 'Delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline_rounded),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text('Delete'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          SizedBox(
                            width: 3.w,
                          ),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Share',
                      child: Row(
                        children: [
                          const Icon(Icons.share_outlined),
                          SizedBox(
                            width: 3.w,
                          ),
                          const Text('Share'),
                        ],
                      ),
                    ),
                  ],
                ).then((value) {
                  if (value == 'Edit') {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditDiaryEntryScreen(entry: widget.entry)));
                  } else if (value == 'Delete') {
                    _showDeleteConfirmationDialog(context, widget.entry);
                  }
                });
              },
              icon: const Icon(Ionicons.ellipsis_vertical_outline,
                  color: Colors.black),
            )
          ],
          bottom: const BottomBorderWidget()
        ),
        body: Container(
         color: hexToColor(widget.entry.background),
          child: ListView(
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
                   const Spacer(),
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
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     if (widget.entry.id != null) {
        //       DbFunctions().deleteDiary(widget.entry.id!);
        //     }
        //     Navigator.pop(context);
        //   },
        //   backgroundColor: Colors.red, // Twitter red color
        //   icon: Icon(Icons.delete, color: Colors.white),
        //   label: const Text(
        //     'Delete',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        );
  }
}
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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
