import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/create_screen/widget/down_icon.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/application/controllers/hive_diary_entry_db_ops.dart';
import 'package:diary/infrastructure/providers/provider_calendar.dart';
import 'package:diary/infrastructure/providers/provider_create.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/screens/widget/save_text_button_common.dart';
import 'package:diary/presentation/util/create_screen_functions.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:sizer/sizer.dart';
import 'package:image/image.dart' as img;


class CreateDiaryScreen extends StatefulWidget {
  final Changer changer;

  const CreateDiaryScreen({Key? key, required this.changer}) : super(key: key);

  @override
  State<CreateDiaryScreen> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateDiaryScreen> {
  late Color selectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize selectedColor in didChangeDependencies
    selectedColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

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
// Read and decode the original image
      final bytes = image.readAsBytesSync();
      final originalImage = img.decodeImage(Uint8List.fromList(bytes));

      // Resize the image if its height is more than 300 pixels
      if (originalImage != null && originalImage.height > 800) {
        final resizedImage = img.copyResize(originalImage, height: 800);
        File(imagePath).writeAsBytesSync(img.encodeJpg(resizedImage));
      } else {
        // Save the original image if its height is not more than 300 pixels
        image.copy(imagePath);
      }

      return imagePath;
   
    } catch (e) {
      log("Error saving image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
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
                                    colorScheme: ColorScheme.dark(
                                      primary: AppColor.darkBuilder.color,
                                      secondary: AppColor.darkFourth.color,
                                    ),
                                  )
                                : ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColor.primary.color,
                                      secondary: AppColor.primary.color,
                                    ),
                                  ),
                            child: child ?? Container(),
                          );
                        },
                      );

                      if (pickedDate != null) {
                        widget.changer.selectDate(pickedDate);
                      }
                    },
                    child: Row(
                      children: [
                        Consumer<Changer>(
                          builder: (context, changer, child) {
                            return Text(
                              DateFormat('d MMMM,y')
                                  .format(changer.selectedDate),
                              style: TextStyle(
                                  color: CreateDiaryScreenFunctions()
                                          .isColorBright(selectedColor)
                                      ? Colors.black
                                      : Colors.white),
                            );
                          },
                        ),
                        CaretDownIcon(
                          selectedColor: selectedColor,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: CreateDiaryScreenFunctions()
                              .isColorBright(selectedColor)
                          ? Colors.black
                          : Colors.white),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.green[900],
                cursorHeight: 28,
                style: TextStyle(
                    fontSize: 28,
                    color: CreateDiaryScreenFunctions()
                            .isColorBright(selectedColor)
                        ? Colors.black
                        : Colors.white),
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                maxLines: 2,
              ),
            ),
            SizedBox(
              child: _image != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _image!,
                          height: 300,
                        ),
                      ),
                    )
                  : Container(),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: 'Start typing here',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CreateDiaryScreenFunctions()
                                .isColorBright(selectedColor)
                            ? Colors.black
                            : Colors.white),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.red[900],
                  cursorHeight: 18,
                  style: TextStyle(
                      fontSize: 18,
                      color: CreateDiaryScreenFunctions()
                              .isColorBright(selectedColor)
                          ? Colors.black
                          : Colors.white),
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
                        : AppColor.dark.color,
                    indicatorColor: const Color(0xFF835DF1),
                    iconColor: Colors.grey,
                    iconColorSelected: const Color(0xFF835DF1),
                    backspaceColor: const Color(0xFF835DF1),
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
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget? child) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        return Theme(
                          data: isDark
                              ? ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: AppColor.darkBuilder.color,
                                    secondary: AppColor.darkFourth.color,
                                  ),
                                )
                              : ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColor.primary.color,
                                    secondary: AppColor.primary.color,
                                  ),
                                ),
                          child: child ?? Container(),
                        );
                      },
                    ).then((pickedTime) {
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
                    CreateDiaryScreenFunctions().showColorPickerDialog(
                        context, selectedColor, (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    });
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
