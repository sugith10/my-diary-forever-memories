import 'dart:developer';
import 'dart:io';
import 'package:diary/core/route/route_name/route_name.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:diary/core/widget/app_snack_bar.dart';

import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:diary/core/util/util/get_theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/util/get_color.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/app_picker_theme.dart';
import '../../view_model/bloc/diary_bloc/create_diary_bloc.dart';
import '../../view_model/provider/create_diary_provider.dart';
import '../widget/image_menu.dart';
import '../widget/create_diary_bottom_navigationbar.dart';
import '../../../../core/widget/save_text_button_common.dart';
import '../widget/color_pick_dialog.dart';
import '../widget/create_diary_textfield.dart';
import '../widget/date_icon_button.dart';
import '../widget/diary_image_widget.dart';

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
  late final String? _id;
  Color _background = Colors.white;
  late DateTime _date;
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      _id = widget.diary!.id;
      _titleController.text = widget.diary!.title;
      _contentController.text = widget.diary!.content;
      _date = widget.diary!.date;
      _background = GetColor.stringToColor(widget.diary!.background);
      if (widget.diary!.imagePath != null) {
        _image = File(widget.diary!.imagePath!);
      }
    } else {
      _id = null;
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
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image?.path != null) {
        setState(
          () {
            _image = File(image!.path);
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.diary == null) {
      _background = isDark(context)
          ? AppDarkColor.instance.background
          : AppLightColor.instance.background;
    }


    return BlocListener<DiaryBloc, DiaryState>(
      listener: (context, state) {
        if (state is DiaryErrorState) {
          AppSnackBar.show(
            context: context,
            title: state.message,
            type: ToastificationType.error,
          );
        }
        if (state is DiarySuccessState) {
          AppSnackBar.show(
            context: context,
            title: "Success",
            type: ToastificationType.success,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.home, (_) => false);
        }
      },
      child: ChangeNotifierProvider(
        create: (context) => CreateDiaryProvider(background: _background),
        child: Selector<CreateDiaryProvider, Color>(
            selector: (context, provider) => provider.background,
            builder: (context, background, _) {
              final createDiaryProvider = context.read<CreateDiaryProvider>();
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: background,
                appBar: DefaultAppBar(
                  children: [
                    SaveButton(
                      onPressed: () {
                        context.read<DiaryBloc>().add(
                              CreateDiaryEvent(
                                title: _titleController.text,
                                description: _contentController.text,
                                date: _date,
                                image: _image,
                                background: GetColor.colorToString(_background),
                                id: _id,
                              ),
                            );
                      },
                    ),
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
                              AppSnackBar.show(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: "Something went wrong",
                                type: ToastificationType.error,
                              );
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
                    _navigateToPage(
                      index,
                      _getImage(),
                      createDiaryProvider,
                    );
                  },
                ),
              );
            }),
      ),
    );
  }

  void _navigateToPage(
    int index,
    Future<dynamic> getImage,
    CreateDiaryProvider provider,
  ) {
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
            provider.changeBackground(color);
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
