import 'dart:developer';
import 'dart:io';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/provider_create.dart';
import 'package:diary/screens/widgets/back_button.dart';
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
      _image = imageTemporary;
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

  Color _selectedColor = Colors.white; // Initial background color

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => const LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Choose Background Color',
              style: TextStyle(fontSize: 24),
            ),
          )),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              availableColors: const [
                Color.fromARGB(255, 248, 248, 248),
                Color.fromARGB(255, 250, 240, 248),
                Color.fromARGB(255, 223, 244, 255),
                Color.fromARGB(255, 229, 215, 162),
                Color.fromARGB(255, 243, 215, 116),
                Color.fromARGB(255, 200, 194, 151),
                Color.fromARGB(255, 244, 181, 104),
               
                Color.fromARGB(255, 200, 216, 145),
                 Color.fromARGB(255, 187, 240, 214),
                Color.fromARGB(255, 122, 236, 198),
                Color.fromARGB(255, 113, 184, 150),
                Color.fromARGB(255, 107, 213, 111),
                Colors.blueGrey,
                Colors.grey,
                Color.fromARGB(255, 164, 151, 200),
                Color.fromARGB(255, 61, 190, 255),
                Color.fromARGB(255, 244, 104, 104),
                Color.fromARGB(255, 250, 105, 48),
                Color.fromARGB(255, 217, 130, 217),
                Color.fromARGB(255, 224, 153, 181),
                Color.fromARGB(255, 111, 98, 98),
                Color.fromARGB(255, 108, 107, 99),
                Color.fromARGB(255, 140, 113, 80),
                Color.fromARGB(255, 76, 75, 88),
              ],
              // enableAlpha: true,

              // pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                String hex =
                    _selectedColor.value.toRadixString(16).toUpperCase();
                print('Selected Color: #$hex');
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false, 
      backgroundColor: _selectedColor,
    
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButtonWidget(),
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
                      background:
                          '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                    );
                    widget.changer.selectDate(DateTime.now());

                    await DbFunctions()
                        .addDiaryEntry(entry)
                        .then((value) async {
                      log("Function completed: $value");

                      var hiveBox = await Hive.openBox<DiaryEntry>('_boxName');
                      final allData = hiveBox.values.toList();
                      log(allData.length.toString());
                      for (var data in allData) {
                        log("Diary Entry: key=${data.id} Date=${data.date}, Title=${data.title}, Content=${data.content}, ImagePath=${data.imagePath}, Background=${data.background}");
                      }
                    }).catchError((error) {
                      log("Error adding DiaryEntry: $error");
                    });
                  }
                  // ignore: use_build_context_synchronously
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
          bottom: const BottomBorderWidget()),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: widget.changer.selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: const Color(0xFF835DF1),
                            colorScheme: const ColorScheme.light(
                                primary: Color(0xFF835DF1)),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child ?? Container(),
                        );
                      },
                    );

                    if (pickedDate != null) {
                      widget.changer.selectDate(pickedDate);

                      // var selectedate = widget.changer.selectedDate;
                    }
                  },
                  child: Row(
                    children: [
                      Consumer<Changer>(
                        builder: (context, changer, child) {
                          return Text(
                            DateFormat('d MMMM,y').format(changer.selectedDate),
                            style: const TextStyle(color: Colors.black),
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
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                style: const TextStyle(fontSize: 18),
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
                  indicatorColor:  Color(0xFF835DF1),
                  iconColor: Colors.grey,
                  iconColorSelected:  Color(0xFF835DF1),
                  backspaceColor:  Color(0xFF835DF1),
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
      bottomNavigationBar: Consumer<CreatePageProvider>(
        builder: (context, bottomNavigationProvider, child) {
          return BottomNavigationBar(
            selectedItemColor:  Color(0xFF835DF1),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavigationProvider.selectedIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                showTimePicker(context: context, initialTime: TimeOfDay.now());
                  break;
                case 1:
                  toggleEmojiKeyboard();
                  // log(_isEmojiKeyboardVisible as String);
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
