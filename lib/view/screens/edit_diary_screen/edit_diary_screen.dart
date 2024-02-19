import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:diary/model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/view/screen_transitions/no_movement.dart';
import 'package:diary/view/screens/create_screen/image_view_screen/image_view_screen.dart';
import 'package:diary/view/screens/main_screen/main_screen.dart';
import 'package:diary/view/screens/widget/back_button.dart';
import 'package:diary/view/screens/widget/create_screen_bottom_navigationbar.dart';
import 'package:diary/view/theme/app_color.dart';
import 'package:diary/controller/database_controller/diary_entry_db_controller.dart';
import 'package:diary/view/screens/widget/appbar_bottom_common.dart';
import 'package:diary/view/screens/widget/save_text_button_common.dart';
import 'package:diary/view/util/create_screen_functions.dart';
import 'package:diary/view/util/get_colors.dart';
import 'package:diary/view/util/individual_diary_page_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class EditDiaryEntryScreen extends StatefulWidget {
  final DiaryEntry entry;

  const EditDiaryEntryScreen({required this.entry, super.key});

  @override
  State<EditDiaryEntryScreen> createState() => _EditDiaryEntryScreenState();
}

class _EditDiaryEntryScreenState extends State<EditDiaryEntryScreen> {
  final TextEditingController titleController;
  final TextEditingController contentController;
  File? _image;
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  _EditDiaryEntryScreenState()
      : titleController = TextEditingController(),
        contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.entry.title;
    contentController.text = widget.entry.content;

    if (widget.entry.imagePath != null) {
      _image = File(widget.entry.imagePath!);
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
      backgroundColor: DiaryDetailPageFunctions()
          .hexToColor(widget.entry.background, context),
      appBar: AppBar(
        leading: const BackButtonWidget(),
        actions: [
          SaveButton(
            onPressed: () {
              _showPopupDialog(context);
            },
          )
        ],
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 24),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    color: CreateDiaryScreenFunctions().isColorBright(
                      DiaryDetailPageFunctions()
                          .hexToColor(widget.entry.background, context),
                    )
                        ? Colors.black
                        : Colors.white,
                  ),
                  cursorColor: Colors.green[900],
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                    hintStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: CreateDiaryScreenFunctions().isColorBright(
                      DiaryDetailPageFunctions()
                          .hexToColor(widget.entry.background, context),
                    )
                        ? Colors.black
                        : Colors.white,
                  ),
                  autofocus: true,
                  cursorColor: Colors.red[900],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CreatePageBottomNav(
        selectedIndexNotifier: _selectedIndexNotifier,
        onTap: (index) {
          // Update the selected index
          _selectedIndexNotifier.value = index;
          // Handle the onTap logic as needed
          _navigateToPage(index);
        },
      ),
    );
  }

  void _showPopupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GetColors().getAlertBoxColor(context),
          title: const Center(
            child: Text(
              'Edit Confirmation',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),
          content: const Text(
            'Are you sure about editing this record?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      const Text('Save', style: TextStyle(color: Colors.red)),
                  onPressed: () async {
                    final title = titleController.text;
                    final content = contentController.text;

                    String? imagePath;
                    if (_image != null) {
                      imagePath = await saveImage(_image!);
                    }

                    if (title.isNotEmpty) {
                      await DiaryEntryDatabaseManager()
                          .updateDiaryEntry(
                              id: widget.entry.id,
                              date: widget.entry.date,
                              title: title,
                              content: content,
                              imagePath: imagePath,
                              background: widget.entry.background)
                          .then((value) {
                        log("DiaryEntry updated successfully!");
                      }).catchError((error) {
                        log("Error updating DiaryEntry: $error");
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.of(context)
                          .pushReplacement(noMovement(MainScreen()));
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          backgroundColor: Colors.red,
                          content: Text('Title cannot be empty!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
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
          context,
          DiaryDetailPageFunctions()
              .hexToColor(widget.entry.background, context),
          (Color color) {
            setState(() {
              widget.entry.background =
                  '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
            });
          },
        );
        break;
    }
  }

  void _showImageMenu(BuildContext context, TapDownDetails details) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      color: GetColors().getAlertBoxColor(context),
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        overlay.size.width - details.globalPosition.dx,
        overlay.size.height - details.globalPosition.dy,
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
              ),
            ),
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
              ),
            ),
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
