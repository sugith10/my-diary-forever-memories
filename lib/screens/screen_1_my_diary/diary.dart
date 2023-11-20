import 'dart:io';
import 'package:diary/db/hive_savedlist_db_ops.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:diary/screens/screen_1_my_diary/edit_screen.dart';
import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
                    //hfhkjasdhjkfhkldhkjhsgldfkjkgljfhssssslhhsdhafhdhasbjkdbfhdhbkjfbhdkfhnksajkfkjsdbjhfvbjsdnvjnskabfdkdhfldjiokshfiakadhnbsdjnasjdgfh
                    _displayBottomSheet(context, widget.entry.id!);
                  }
                });
              },
              icon: const Icon(Ionicons.ellipsis_vertical_outline,
                  color: Colors.black),
            )
          ],
          bottom: const BottomBorderWidget()),
      body: Container(
        color: hexToColor(widget.entry.background),
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
                    fontFamily: "SFPRO",
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

Future _displayBottomSheet(BuildContext context, String entryId) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) => Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              width: 10.w,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black, // Change the color as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text('Save diary to...', style: TextStyle(fontSize: 17.sp))
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          ValueListenableBuilder(
            valueListenable:
                Hive.box<SavedList>('_savedListBoxName').listenable(),
            builder: (context, box, child) {
              List<SavedList> savedList = box.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: savedList.length,
                itemBuilder: (context, index) {
                  String listName = savedList[index].listName;
                  String listId = savedList[index].id;
                  return InkWell(
                    onTap: () {
                      print(listId);
                      print(entryId);
                       SavedListDbFunctions().addMapToDiaryEntryIds(listId, entryId );
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              listName,
                              style: TextStyle(fontSize: 16.5.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(
            thickness: 1.5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Icon(Icons.check_rounded),
                  SizedBox(
                    width: 9.sp,
                  ),
                  Text(
                    'Done',
                    style: TextStyle(fontSize: 16.5.sp),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
