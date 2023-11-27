import 'dart:io';
import 'package:diary/color/primary_colors.dart';
import 'package:diary/screens/main_screen/main_screen.dart';
import 'package:diary/screens/edit_screen/edit_screen.dart';
import 'package:diary/screens/widget/back_button.dart';
import 'package:diary/screens/widget/appbar_bottom.dart';
import 'package:diary/util/diary_screen_functions.dart';
import 'package:diary/util/saved_list_functions.dart';
import 'package:flutter/material.dart';
import 'package:diary/controllers/hive_operations.dart';
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
          elevation: 0,
          leading: const BackButtonWidget(),
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : AppColor.showMenuBlack.color,
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
                          const Text('Delete'),
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
                      value: 'Save',
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark_outline_sharp),
                          SizedBox(
                            width: 3.w,
                          ),
                          const Text('Save'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditDiaryEntryScreen(entry: widget.entry)));
                  } else if (value == 'Delete') {
                    _showDeleteConfirmationDialog(context, widget.entry);
                  } else if (value == 'Save') {
                    SavedScreenFunctions()
                        .displayBottomSheet(context, widget.entry.id!);
                  }
                });
              },
              icon: const Icon(
                Ionicons.ellipsis_vertical_outline,
              ),
            )
          ],
          bottom: const BottomBorderWidget()),
      body: Container(
        color: DiaryScreenFunctions().hexToColor(widget.entry.background),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('d MMMM,y').format(widget.entry.date),
                  style: TextStyle(
                    fontSize: 11.sp,
                    // color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.entry.title,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "SFPRO",
                          fontWeight: FontWeight.w700),
                      // overflow: TextOverflow.ellipsis,
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
              child: Text(widget.entry.content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    // wordSpacing: .2,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.justify),
            ),
          ],
        ),
      ),
    );
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
