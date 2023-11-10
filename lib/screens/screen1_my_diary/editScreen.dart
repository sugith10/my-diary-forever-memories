import 'dart:io';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/home/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:ionicons/ionicons.dart';

class EditDiaryEntryScreen extends StatefulWidget {
  final DiaryEntry entry;

  EditDiaryEntryScreen({required this.entry, Key? key}) : super(key: key);

  @override
  State<EditDiaryEntryScreen> createState() => _EditDiaryEntryScreenState();
}

class _EditDiaryEntryScreenState extends State<EditDiaryEntryScreen> {
  final TextEditingController titleController;
  final TextEditingController contentController;
  File? _image;

  _EditDiaryEntryScreenState() 
      : titleController = TextEditingController(),
        contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.entry.title;
    contentController.text = widget.entry.content;

    if (widget.entry.imagePath != null) {
      _image = File(widget.entry.imagePath!);
    }
  }

  // ... Rest of your code for image selection, save, and emoji handling.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 25),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;

                String? imagePath;
                if (_image != null) {
                  imagePath = await saveImage(_image!);
                }

                if (title.isNotEmpty) {
                  final updatedEntry = DiaryEntry(
                    id: widget.entry.id,
                    date: widget.entry.date,
                    title: title,
                    content: content,
                    imagePath: imagePath,
                  );

                  await DbFunctions()
                      .updateDiaryEntry(updatedEntry)
                      .then((value) {
                    print("Function completed: ");
                  }).catchError((error) {
                    print("Error updating DiaryEntry: $error");
                  });
                }
                Navigator.pop(context);
              },
              child: const Text(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 24),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Container(
  height: 200,
  child: _image != null
      ? FocusedMenuHolder(
        menuItems: [FocusedMenuItem(
            title: Text('Favourite'),
            trailingIcon: Icon(Icons.favorite_border),
            onPressed: () => null,
          ),
           FocusedMenuItem(
            title: Text('Delete', style: TextStyle(color: Colors.white)),
            trailingIcon: Icon(Icons.delete_forever, color: Colors.white),
            backgroundColor: Colors.red,
            onPressed: () =>null,
          ),
          ],
        onPressed: (){},
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _image!,
            ),
          ),
      )
      : Container(),
),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: contentController,
                maxLines: null, // Allows for multiple lines
                decoration: const InputDecoration(
                  hintText: 'Content',
                  hintStyle: TextStyle(fontSize: 18),
                   border: InputBorder.none,

                ),
                style: TextStyle(fontSize: 18),
                autofocus: true,
              ),
            ),
          ),
          // Add image selection and emoji handling widgets 
        ],
      ),
    );
  }

  saveImage(File file) {}

  // ... Rest of your methods for image selection, emoji handling, and backspace pressed.
}

void _showPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Edit Confirmation',
          style: TextStyle(
            fontSize: 27,
          ),
        ),
        content: const Text(
          'Are you sure about editing this record?',
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
            child: const Text('Save', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                ModalRoute.withName('/main'),
              );
            },
          ),
        ],
      );
    },
  );
}
