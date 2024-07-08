import 'dart:developer';
import 'dart:io';
import 'package:diary/data/controller/image_pick_controller/image_pick_controller.dart';
import 'package:diary/data/model/hive/diary_entry_db_model/diary_entry.dart';

import 'package:diary/view/components/snackbar_message.dart';
import 'package:diary/view/theme/color/app_color.dart';
import 'package:diary/data/controller/database_controller/diary_entry_db_controller.dart';
import 'package:diary/view_model/providers/calendar_scrn_prvdr.dart';
import 'package:diary/view/util/create_screen_functions.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../../components/app_custom_app_bar.dart';
import '../image_view_page/image_view_page.dart';
import '../widget/create_screen_bottom_navigationbar.dart';
import '../widget/save_text_button_common.dart';
import 'widget/down_icon.dart';

// ignore: must_be_immutable
class CreateDiaryPage extends StatefulWidget {
  final CalenderPageProvider? changer;
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);
  DateTime date = DateTime.now();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      _titleController.text = widget.diary!.title;
      _contentController.text = widget.diary!.content;
      date = widget.diary!.date;
      if (widget.diary!.imagePath != null) {
        _image = File(widget.diary!.imagePath!);
      }
    } else {
      date = widget.changer!.selectedDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(
      () {
        _image = imageTemporary;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.selectedColor,
      appBar: CustomAppBar(
        children: [
          SaveButton(onPressed: () async {
            final String title = _titleController.text;
            final String content = _contentController.text;

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

                await DiaryEntryDatabaseManager().addDiaryEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: date,
                  title: title,
                  content: content,
                  background:
                      '#${widget.selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                  imagePath: imagePath,
                );
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
                  Navigator.popUntil(context, (route) => route.isFirst);
                }).catchError((error) {});
              }
            } else {
              SnackBarMessage(
                message: "Title can't be empty...",
                color: const Color.fromARGB(255, 225, 43, 43),
              ).scaffoldMessenger(context);
            }
          }),
        ],
      ),
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
                        Consumer<CalenderPageProvider>(
                          builder: (context, changer, child) {
                            return Text(
                              DateFormat('d MMMM,y').format(date),
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
                controller: _titleController,
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
                maxLines: null,
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
                  controller: _contentController,
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
            String existingText = _contentController.text;

            String newText = existingText.isNotEmpty
                ? '$existingText\n\n\n$formattedTime\n\n'
                : '$formattedTime\n\n';

            _contentController.value = TextEditingValue(
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
