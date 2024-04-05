import 'dart:developer';
import 'dart:io';
import 'package:diary/controller/image_pick_controller/image_pick_controller.dart';
import 'package:diary/core/data/model/hive/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/core/presentation/pages/pages/image_view_page/image_view_page.dart';
import 'package:diary/core/presentation/pages/pages/create_page/widget/down_icon.dart';
import 'package:diary/core/presentation/pages/pages/widget/back_button.dart';
import 'package:diary/core/presentation/pages/pages/widget/create_screen_bottom_navigationbar.dart';
import 'package:diary/core/presentation/widgets/snackbar_message.dart';
import 'package:diary/core/presentation/theme/app_color.dart';
import 'package:diary/controller/database_controller/diary_entry_db_controller.dart';
import 'package:diary/core/presentation/providers/calendar_scrn_prvdr.dart';
import 'package:diary/core/presentation/pages/pages/widget/appbar_bottom_common.dart';
import 'package:diary/core/presentation/pages/pages/widget/save_text_button_common.dart';
import 'package:diary/core/presentation/pages/util/create_screen_functions.dart';
import 'package:diary/core/presentation/pages/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CreateDiaryPage extends StatefulWidget {
  final CalenderScreenProvider? changer;
  final DiaryEntry? diary;
  Color selectedColor;

  CreateDiaryPage({
    super.key,
    required this.selectedColor,
    this.changer,
    this.diary,
  });

  @override
  State<CreateDiaryPage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateDiaryPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);
  DateTime date = DateTime.now();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      titleController.text = widget.diary!.title;
      contentController.text = widget.diary!.content;
      date = widget.diary!.date;
      if (widget.diary!.imagePath != null) {
        _image = File(widget.diary!.imagePath!);
      }
    } else {
      date = widget.changer!.selectedDate;
    }
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.selectedColor,
      appBar: AppBar(
          leading: const BackButtonWidget(),
          actions: [
            SaveButton(onPressed: () async {
              final String title = titleController.text;
              final String content = contentController.text;

              if (title.isNotEmpty) {
                if (widget.diary == null) {
                  Navigator.pop(context);
                  String? imagePath;
                  if (_image != null) {
                    imagePath = await ImagePickCntrl().saveImage(_image!);
                  }
                  if (widget.changer != null) {
                    widget.changer!.selectDate(DateTime.now());
                  }

                  await DiaryEntryDatabaseManager()
                      .addDiaryEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    date: date,
                    title: title,
                    content: content,
                    background:
                        '#${widget.selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                    imagePath: imagePath,
                  )
                      .then((value) {
                    log("DiaryEntry updated successfully!");
                  }).catchError((error) {
                    log("Error updating DiaryEntry: $error");
                  });
                } else {
                  //edit diary
                  log('edit');
                  String? imagePath;
                  if (_image != null) {
                    imagePath = await ImagePickCntrl().saveImage(_image!);
                  }
                  if (widget.changer != null) {
                    widget.changer!.selectDate(DateTime.now());
                  }
                  await DiaryEntryDatabaseManager()
                      .updateDiaryEntry(
                    id: widget.diary!.id,
                    date: date,
                    title: title,
                    content: content,
                    imagePath: imagePath,
                    background:
                        '#${widget.selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                  )
                      .then((value) {
                    log("DiaryEntry updated successfully!");
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }).catchError((error) {
                    log("Error updating DiaryEntry: $error");
                  });
                }
              } else {
                SnackBarMessage(
                  message: "Title can't be empty...",
                  color: const Color.fromARGB(255, 225, 43, 43),
                ).scaffoldMessenger(context);
              }
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
                  IconButton(
                    onPressed: () async {
                      try {
                        log('one pick function');
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: date,
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
                              child: child ?? const SizedBox(),
                            );
                          },
                        );
                        if (pickedDate != null) {
                          date = pickedDate;
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    icon: Row(
                      children: [
                        Consumer<CalenderScreenProvider>(
                          
                          builder: (context, changer, child) {
                            return Text(
                              DateFormat('d MMMM,y')
                                  .format(date),
                              style: TextStyle(
                                color: CreateDiaryScreenFunctions()
                                        .isColorBright(widget.selectedColor)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            );
                          },
                        ),
                        CaretDownIcon(
                          selectedColor: widget.selectedColor,
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
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: CreateDiaryScreenFunctions()
                            .isColorBright(widget.selectedColor)
                        ? Colors.black
                        : Colors.white,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: const Color.fromRGBO(27, 94, 32, 1),
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: CreateDiaryScreenFunctions()
                            .isColorBright(widget.selectedColor)
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
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: GestureDetector(
                        onTapDown: (details) {
                          _showImageMenu(context, details);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _image!,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
            SizedBox(
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
                                .isColorBright(widget.selectedColor)
                            ? Colors.black
                            : Colors.white),
                    border: InputBorder.none,
                  ),
                  cursorColor: const Color.fromRGBO(183, 28, 28, 1),
                  style: TextStyle(
                      fontSize: 18,
                      color: CreateDiaryScreenFunctions()
                              .isColorBright(widget.selectedColor)
                          ? Colors.black
                          : Colors.white),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CreatePageBottomNav(
        selectedIndexNotifier: _selectedIndexNotifier,
        onTap: (index) {
          _selectedIndexNotifier.value = index;
          _navigateToPage(index);
        },
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
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
              selection: TextSelection.collapsed(offset: newText.length),
            );
          }
        });
        break;

      case 1:
        getImage();

        break;
      case 2:
        CreateDiaryScreenFunctions().showColorPickerDialog(
            context, widget.selectedColor, (Color color) {
          setState(() {
            widget.selectedColor = color;
          });
        });
        break;
    }
  }

  void _showImageMenu(BuildContext context, TapDownDetails details) {
    showMenu(
      color: GetColors().getAlertBoxColor(context),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewerPage(imageFile: _image!),
                ),
              );
            },
            child: const Center(
                child: Text(
              'Open',
              style: TextStyle(fontSize: 17),
            )),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () {
              getImage();
              Navigator.pop(context);
            },
            child: const Center(
                child: Text(
              'Change',
              style: TextStyle(fontSize: 17),
            )),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () {
              _removePhoto();
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                'Remove',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _removePhoto() {
    setState(() {
      _image = null;
    });
  }
}
