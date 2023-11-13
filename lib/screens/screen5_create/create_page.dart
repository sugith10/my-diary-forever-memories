import 'dart:developer';
import 'dart:io';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/provider_create.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:sizer/sizer.dart';

class CreatePage extends StatefulWidget {
  final Changer changer;

  const CreatePage({Key? key, required this.changer}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  bool _isEmojiKeyboardVisible = false;

  _onBackspacePressed() {
    contentController
      ..text = contentController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: contentController.text.length));
  }

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

  Color _selectedColor = Colors.white;// Initial background color

  

 void _showColorPickerDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Background Color'),
        
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
            enableAlpha: true,
            showLabel: false,
            pickerAreaHeightPercent: 0.8,
            
          ),
        ),
        
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),
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
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    date: widget.changer.selectedDate,
                    title: title,
                    content: content,
                    imagePath: imagePath,
                  );
                  widget.changer.selectDate(DateTime.now());

                  await DbFunctions().addDiaryEntry(entry).then((value) async {
                    log("Function completed: $value");

                    var hiveBox = await Hive.openBox<DiaryEntry>('_boxName');
                    final allData = hiveBox.values.toList();
                    log(allData.length.toString());
                    for (var data in allData) {
                      log("Diary Entry: key=${data.id} Date=${data.date}, Title=${data.title}, Content=${data.content}, ImagePath=${data.imagePath}");
                    }
                  }).catchError((error) {
                    log("Error adding DiaryEntry: $error");
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
        bottom:  const BottomBorderWidget()
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: widget.changer.selectedDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        widget.changer.selectDate(pickedDate);
                        print(widget.changer.selectedDate);
                        // var selectedate = widget.changer.selectedDate;
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: ' Title',
                  hintStyle: TextStyle(fontSize: 28),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.green[900],
                cursorHeight: 28,
                style: const TextStyle(fontSize: 28),
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
              ),
            ),
            Container(
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _image!,
                        height: 200,
                      ),
                    )
                  : Container(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
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
              ),
            ),
            Offstage(
              offstage: !_isEmojiKeyboardVisible,
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: EmojiPicker(
                  textEditingController: contentController,
                  onBackspacePressed: _onBackspacePressed,
                  onEmojiSelected: (Category? category, Emoji? emoji) {
                    if (emoji != null) {
                      // Handle the selected emoji (e.g., add it to the text field)
                      contentController.text += emoji.emoji;
                    }
                  },
                  config: Config(
                    columns: 8,
                    emojiSizeMax: 32 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.30
                            : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    recentTabBehavior: RecentTabBehavior.RECENT,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<CreatePageProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavigationProvider.selectedIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  break;
                case 1:
                  toggleEmojiKeyboard();
                  print(_isEmojiKeyboardVisible);
                  break;
                case 2:
                
                  getImage();
                  break;
                case 3:
                 _showColorPickerDialog();
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
    );
    
  }

  void toggleEmojiKeyboard() {
    setState(() {
      _isEmojiKeyboardVisible = !_isEmojiKeyboardVisible;
    });
  }
}

