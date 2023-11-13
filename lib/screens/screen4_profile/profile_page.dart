import 'dart:developer';
import 'dart:io';
import 'package:diary/models/profile_details.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../../db/hive_profile_operations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _profilePicture;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._profilePicture = imageTemporary;
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
    final profileFunctions = ProfileFunctions();
    final List<ProfileDetails> profileDetailsList =
        profileFunctions.getAllProfileDetails();

    final ProfileDetails profileDetails = profileDetailsList.isNotEmpty
        ? profileDetailsList.first
        : ProfileDetails(name: '', email: ''); // Provide default values

    if (_profilePicture == null && profileDetails.profilePicturePath != null) {
      _profilePicture = File(profileDetails.profilePicturePath!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 25),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                await saveProfileDetails();
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
        elevation: 0,
        bottom:  const BottomBorderWidget()
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<ProfileDetails>('_profileBoxName').listenable(),
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
                                : profileDetails.profilePicturePath != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(profileDetails
                                              .profilePicturePath!),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage('images/profile.png'),
                                        fit: BoxFit.cover,
                                      ),
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                                  color: Color(0xFF835DF1)),
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
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF835DF1))),
                          contentPadding:
                              const EdgeInsets.only(left: 0, bottom: 3),
                          labelText: "Name",
                          labelStyle: const TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: profileDetails.name , // Check for null before using the value,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //     RegExp(r'^[a-zA-Z ]+$'),
                      //   ),
                      // ],
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
                            color: Colors.black,
                          )),
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
                            color: Colors.black,
                          )),
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

  Future<void> saveProfileDetails() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty) {
      final String? imagePath =
          _profilePicture != null ? await saveImage(_profilePicture!) : null;

      final ProfileDetails details = ProfileDetails(
        id: '1',
        name: name,
        email: email,
        location: _locationController.text.trim(),
        profilePicturePath: imagePath,
      );

      await ProfileFunctions().addProfileDetails(details);

      // log('Profile details added: $details');
      log("Diary Entry: key=${details.id}  Name=${details.name}, Email=${details.email}, ImagePath=${details.profilePicturePath}");
    } else {
      log('something missing');
    }
  }
}
