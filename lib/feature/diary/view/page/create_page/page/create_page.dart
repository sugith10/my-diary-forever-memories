import 'dart:developer';
import 'dart:io';
import 'package:diary/core/route/route_name/route_name.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';

import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:diary/view/util/get_theme_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/widget/custom_app_bar.dart';
import '../../../../../../core/widget/app_picker_theme.dart';
import '../../../widget/image_menu.dart';
import '../../../widget/create_diary_bottom_navigationbar.dart';
import '../../../../../../view/page/widget/save_text_button_common.dart';
import '../../../widget/color_pick_dialog.dart';
import '../../../widget/create_diary_textfield.dart';
import '../../../widget/date_icon_button.dart';
import '../../../widget/diary_image_widget.dart';

class CreateDiaryPage extends StatefulWidget {
  final DiaryModel? diary;

  const CreateDiaryPage({
    super.key,
    this.diary,
  });

  @override
  State<CreateDiaryPage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateDiaryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Color _background = Colors.white;
  late DateTime _date;
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      _titleController.text = widget.diary!.title;
      _contentController.text = widget.diary!.content;
      _date = widget.diary!.date;
      _background = widget.diary!.background;
      if (widget.diary!.imagePath != null) {
        _image = File(widget.diary!.imagePath!);
      }
    } else {
      _date = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      setState(
        () {
          _image = File(image!.path);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.diary == null) {
      _background = isDark(context)
          ? AppDarkColor.instance.background
          : AppLightColor.instance.background;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _background,
      appBar: DefaultAppBar(
        children: [
          SaveButton(onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              DateIconButton(
                date: _date,
                callback: () async {
                  try {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.calendar,
                      builder: (BuildContext context, Widget? child) {
                        return AppPickerTheme(child: child);
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _date = pickedDate;
                      });
                    }
                  } catch (e) {
                    //TODO: fix log
                    log(e.toString());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    CreateDairyTextField(
                      capitalization: TextCapitalization.sentences,
                      hintText: "Title",
                      controller: _titleController,
                      background: _background,
                      fontSize: 20,
                    ),
                    DiaryImageWidget(
                      image: _image,
                      callback: (details) {
                        ImageMenu.showImageMenu(
                          context: context,
                          details: details,
                          openImageCall: () => Navigator.pushNamed(
                            context,
                            RouteName.image,
                            arguments: _image!,
                          ),
                          changeImageCall: () => _getImage(),
                          removeImageCall: () => _removePhoto(),
                        );
                      },
                    ),
                    CreateDairyTextField(
                      capitalization: TextCapitalization.sentences,
                      hintText: 'Start typing here',
                      controller: _contentController,
                      background: _background,
                      fontSize: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CreateDiaryBottomBar(
        function: (index) {
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
            return AppPickerTheme(child: child);
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
        _getImage();

        break;
      case 2:
        ColorPickDialog.showColorPickerDialog(
          context,
          _background,
          (Color color) {
            setState(
              () {
                _background = color;
              },
            );
          },
        );
        break;
    }
  }

  void _removePhoto() {
    setState(() {
      _image = null;
    });
  }
}
