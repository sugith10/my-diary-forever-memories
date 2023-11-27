import 'dart:developer';
import 'dart:io';
import 'package:diary/domain/models/diary_entry.dart';
import 'package:diary/presentation/theme/primary_colors.dart';
import 'package:diary/application/controllers/hive_operations.dart';
import 'package:diary/infrastructure/providers/provider_calendar.dart';
import 'package:diary/infrastructure/providers/provider_create.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom.dart';
import 'package:diary/presentation/screens/widget/save_text_button.dart';
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

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black; // Initial background color

    void showColorPickerDialog() {
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
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    selectedColor = color;
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
                  Color.fromARGB(255, 134, 193, 223),
                  Color.fromARGB(255, 201, 112, 112),
                  Color.fromARGB(255, 250, 142, 99),
                  Color.fromARGB(255, 217, 130, 217),
                  Color.fromARGB(255, 224, 153, 181),
                  Color.fromARGB(255, 111, 98, 98),
                  Color.fromARGB(255, 108, 107, 99),
                  Color.fromARGB(255, 140, 113, 80),
                  Color.fromARGB(255, 97, 96, 108),
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
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: selectedColor,
      appBar: AppBar(
          leading: const BackButtonWidget(),
          actions: [
            SaveButton(onPressed: () async {
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
                      '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                );
                widget.changer.selectDate(DateTime.now());

                await DbFunctions().addDiaryEntry(entry).then((value) async {
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
            }),
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
                       initialEntryMode: DatePickerEntryMode.calendar,
                      builder: (BuildContext context, Widget? child) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Theme(
                          data: isDark
                              ? ThemeData.dark().copyWith(
                                  primaryColor: const Color(0xFF835DF1),
                                  colorScheme: const ColorScheme.dark(
                                      primary: Color(0xFF835DF1)),
                                  buttonTheme: const ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                )
                              : ThemeData.light().copyWith(
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
                          );
                        },
                      ),
                      const Icon(
                        Ionicons.caret_down_outline,
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
                hintStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
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
                  hintStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                  bgColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : AppColor.black.color,
                  indicatorColor: const Color(0xFF835DF1),
                  iconColor: Colors.grey,
                  iconColorSelected: const Color(0xFF835DF1),
                  backspaceColor: const Color(0xFF835DF1),
                  // skinToneDialogBgColor: Colors.white,
                  // skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentTabBehavior: RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  replaceEmojiOnLimitExceed: false,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20),
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
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BottomNavigationBar(
              selectedItemColor: const Color(0xFF835DF1),
              showUnselectedLabels: false,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigationProvider.selectedIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((pickedTime) {
                      if (pickedTime != null) {
                        String formattedTime = pickedTime.format(context);
                        String existingText = contentController.text;

                        String newText = existingText.isNotEmpty
                            ? '$existingText\n\n\n$formattedTime\n\n'
                            : '$formattedTime\n\n';

                        contentController.value = TextEditingValue(
                          text: newText,
                          selection:
                              TextSelection.collapsed(offset: newText.length),
                        );
                      }
                    });
                    break;

                  case 1:
                    _toggleEmojiKeyboard();

                    break;
                  case 2:
                    getImage();
                    break;
                  case 3:
                    showColorPickerDialog();
                    break;
                }
                bottomNavigationProvider.setSelectedIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Ionicons.time_outline,
                  ),
                  label: 'Time',
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
            ),
          );
        },
      ),
    );
  }

  void _toggleEmojiKeyboard() {
    setState(() {
      _isEmojiKeyboardVisible = !_isEmojiKeyboardVisible;
    });
  }
}
