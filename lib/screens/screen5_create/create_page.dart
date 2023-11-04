import 'dart:developer';
import 'dart:io';

import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';

import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/emoji_picker.dart';
import 'package:diary/screens/screen5_create/provider_create.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;

class CreatePage extends StatefulWidget {
  // late  DateTime selectedDate;
  final Changer changer; // Inject Changer here

  CreatePage({Key? key, required this.changer}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  bool _showEmoji = false;

  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  Future<String?> saveImage(File image) async {
  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final imagePath = "${appDocDir.path}/$uniqueFileName.jpg";
    await image.copy(imagePath);
    return imagePath;
  } catch (e) {
    log("Error saving image: $e");
    return null;
  }
}


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

  String? imagePath;
  if (_image != null) {
    imagePath = await saveImage(_image!);
  }

  if (title.isNotEmpty) {
    final entry = DiaryEntry(
      date: widget.changer.selectedDate,
      title: title,
      content: content,
      imagePath: imagePath,
    );

    await DbFunctions().addDiaryEntry(entry).then((value) async {
      log("Function completed: $value");

      // Print all data in the Hive box
      var hiveBox = await Hive.openBox<DiaryEntry>('_boxName'); 
      final allData = hiveBox.values.toList();
   
     log(allData.length.toString() );
      for (var data in allData) {
        log("Diary Entry: Date=${data.date}, Title=${data.title}, Content=${data.content}, ImagePath=${data.imagePath}");
      }
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
                      initialDate: widget.changer.selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2029),
                    );
                    if (pickedDate != null) {
                      widget.changer.selectDate(pickedDate);
                      print(widget.changer.selectedDate);
                      var selectedate = widget.changer.selectedDate;
                    }
                  },
                  child: Row(
                    children: [
                      Consumer<Changer>(
                        builder: (context, changer, child) {
                          return Text(
                            DateFormat('d MMMM,y').format(changer.selectedDate),
                            style: TextStyle(color: Colors.black),
                          );
                        },
                      ),
                      const Icon(
                        Ionicons.caret_down_outline,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Spacer(),
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

            Container(
  child: _image != null ? ClipRRect(
    borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
    child: Image.file(
      _image!,
      height: 200, // Adjust the height as needed
    ),
  ) : Container(), // Placeholder or empty container if _image is null
)
,
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: '  Start typing here',
                hintStyle: TextStyle(fontSize: 18),
                border: InputBorder.none,
              ),
              cursorColor: Colors.red[900],
              cursorHeight: 18,
              style: TextStyle(fontSize: 18),
              textCapitalization: TextCapitalization.sentences,
            ),
            //             SizedBox(
            //               height: 100,
            //               child: EmojiPicker(
            //                 textEditingController: contentController,
            //                 onEmojiSelected: (emoji) {
            //   // Handle the selected emoji (e.g., add it to the text field)
            //   contentController.text += emoji.emoji;
            // },
            //                 config: Config(
            //                   columns: 7,
            //                   emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            //                 )),
            //             )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<CreatePageProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavigationProvider
                .selectedIndex, // Use the selected index from the provider
            onTap: (index) {
              // Update the selected index using the provider
              switch (index) {
                case 0:
                  //Font
                  Navigator.pop(context);
                  break;
                case 1:
                  //Emoji
                  //  openEmojiPicker(context);
                  _showEmoji = !_showEmoji;
                  break;
                case 2:
                  //Gallery
                  getImage();
                  break;
                case 3:
                  //Color
                  Navigator.pop(context);
                  break;
              }
              bottomNavigationProvider.setSelectedIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.text_outline,
                ),
                label: 'Font',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.happy_outline),
                label: 'Emoji',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.image_outline),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.color_palette_outline),
                label: 'Color',
              ),
            ],
          );
        },
      ),
    ));
  }
}

// void openEmojiPicker(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return EmojiPicker(
//         onEmojiSelected: (Emoji emoji) {
//           // Handle the selected emoji (e.g., append it to the text)
//           final selectedEmoji = emoji.emoji;
//           // You can use the selected emoji as needed
//           Navigator.pop(context); // Close the emoji picker dialog
//         },
//       );
//     },
//   );
// }
