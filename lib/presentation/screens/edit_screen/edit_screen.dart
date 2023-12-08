import 'dart:io';
import 'package:diary/application/controllers/hive_diary_entry_db_ops.dart';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/screens/widget/create_screen_bottom_navigationbar.dart';
import 'package:diary/presentation/screens/widget/save_text_button_common.dart';
import 'package:diary/presentation/util/create_screen_functions.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:diary/presentation/util/individual_diary_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
      await image.copy(imagePath);
      return imagePath;
    } catch (e) {
      print("Error saving image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          DiaryDetailPageFunctions().hexToColor(widget.entry.background),
      appBar: AppBar(
          leading: const BackButtonWidget(),
          actions: [
            SaveButton(onPressed: () {
              _showPopupDialog(context);
            })
          ],
          elevation: 0,
          bottom: const BottomBorderWidget()),
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
                                  .hexToColor(widget.entry.background))
                          ? Colors.black
                          : Colors.white),
                  cursorColor: Colors.green[900],
                ),
              ),
              SizedBox(
                // height: 200,
                child: _image != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                                  .hexToColor(widget.entry.background))
                          ? Colors.black
                          : Colors.white),
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
          title: const Text(
            'Edit Confirmation',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          content: const Text(
            'Are you sure about editing this record?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;

                String? imagePath;
                if (_image != null) {
                  imagePath = await saveImage(_image!);
                }

                if (title.isNotEmpty) {
                  final updatedEntry = DiaryEntry(
                    id: widget.entry.id,
                    date: widget.entry.date,
                    title: title,
                    content: content,
                    imagePath: imagePath,
                    background: widget.entry.background,
                  );

                  await DbFunctions()
                      .updateDiaryEntry(updatedEntry)
                      .then((value) {
                    print("Function completed: ");
                  }).catchError((error) {
                    print("Error updating DiaryEntry: $error");
                  });
                }
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  ModalRoute.withName('/main'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}


void _navigateToPage(int index) {
    switch (index) {
      case 0:
        // Handle time navigation
        break;
      case 1:
        // Handle gallery navigation
      
        break;
      case 2:
       
        break;
    }
  }
