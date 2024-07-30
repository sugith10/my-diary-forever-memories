import 'dart:io';
import 'package:diary/feature/profile/data/profile_details_db_controller.dart';
import 'package:diary/core/model/user_model/user_model.dart';
import 'package:diary/core/util/util/get_colors.dart';
import 'package:diary/core/util/util/save_image.dart';
import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widget/save_text_button_common.dart';

class EditProfScreen extends StatefulWidget {
  const EditProfScreen({super.key});

  @override
  State<EditProfScreen> createState() => _EditProfScreenState();
}

class _EditProfScreenState extends State<EditProfScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _profilePicture;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      _profilePicture = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<UserModel> userModelList =
        UserModelDatabaseManager().getAllUserModel();

    final UserModel userModel = userModelList.isNotEmpty
        ? userModelList.first
        : UserModel(name: '', email: '');
    if (userModelList.isNotEmpty) {
      _nameController.text = userModel.name;
      _emailController.text = userModel.email;
      if (userModel.location != null) {
        _locationController.text = userModel.location!;
      }
    }

    if (_profilePicture == null && userModel.profilePicturePath != null) {
      _profilePicture = File(userModel.profilePicturePath!);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_rounded, size: 25),
        ),
        actions: [
          SaveButton(
            onPressed: () async {
              await saveUserModel();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<UserModel>('profileBox').listenable(),
            builder: (context, box, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: _profilePicture != null
                                ? DecorationImage(
                                    image: FileImage(_profilePicture!),
                                    fit: BoxFit.cover,
                                  )
                                : userModel.profilePicturePath != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(userModel
                                              .profilePicturePath!),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(AppPng.profile),
                                        fit: BoxFit.cover,
                                      ),
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                // offset: Offset(6, 8),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3.5,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  color: const Color(0xFF835DF1)),
                              child: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF835DF1))),
                        contentPadding: EdgeInsets.only(left: 0, bottom: 3),
                        labelText: "Name",
                        hintText: "UserModel Name",
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      cursorColor: GetColors().getFontColor(context),
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF835DF1))),
                          contentPadding: EdgeInsets.only(left: 0, bottom: 3),
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "sample@gmail.com",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      cursorColor: GetColors().getFontColor(context),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF835DF1))),
                          contentPadding: EdgeInsets.only(left: 0, bottom: 3),
                          labelText: "Location",
                          labelStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Location",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      cursorColor: GetColors().getFontColor(context),
                      textCapitalization: TextCapitalization.words,
                      controller: _locationController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> saveUserModel() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    if (name.isNotEmpty && email.isNotEmpty) {
      final String? imagePath = _profilePicture != null
          ? await SaveImageUtil().saveImage(_profilePicture!)
          : null;
      final UserModel details = UserModel(
        name: name,
        email: email,
        location: _locationController.text.trim(),
        profilePicturePath: imagePath,
      );
      await UserModelDatabaseManager().addUserModel(details);
      // log('Profile details added: $details');
      if (mounted) {
        Navigator.pop(context);
      } else {}
    } else {
//problem with coustom snackbar widget -> leave it...
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Center(
            child: Text(
              "Fill all fields...",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
