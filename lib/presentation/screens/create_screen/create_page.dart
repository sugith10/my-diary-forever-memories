import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/presentation/screens/create_screen/image_view_screen.dart';
import 'package:diary/presentation/screens/create_screen/widget/down_icon.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/screens/widget/create_screen_bottom_navigationbar.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/controllers/diary_entry_db_ops_hive.dart';
import 'package:diary/providers/provider_calendar.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/screens/widget/save_text_button_common.dart';
import 'package:diary/presentation/util/create_screen_functions.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:image/image.dart' as img;

// ignore: must_be_immutable
class CreateDiaryPage extends StatefulWidget {
  final Changer changer;
  Color selectedColor;

  CreateDiaryPage(
      {super.key, required this.changer, required this.selectedColor});

  @override
  State<CreateDiaryPage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateDiaryPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

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

      // Resize the image if its height is more than 800 pixels
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
      backgroundColor: widget.selectedColor,
      appBar: AppBar(
          leading: const BackButtonWidget(),
          actions: [
            SaveButton(onPressed: () async {
              final title = titleController.text;
              final content = contentController.text;

              if (title.isNotEmpty) {
                Navigator.pop(context);
                String? imagePath;
                if (_image != null) {
                  imagePath = await saveImage(_image!);
                }
                final entry = DiaryEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: widget.changer.selectedDate,
                  title: title,
                  content: content,
                  imagePath: imagePath,
                  background:
                      '#${widget.selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(10),
                    backgroundColor: Colors.red,
                    content: Text('Title cannot be empty!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              // ignore: use_build_context_synchronously
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
                                          .isColorBright(widget.selectedColor)
                                      ? Colors.black
                                      : Colors.white),
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
                          : Colors.white),
                  border: InputBorder.none,
                ),
                cursorColor: const Color.fromRGBO(27, 94, 32, 1),
               
                style: TextStyle(
                    fontSize: 25,
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
