import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  File? _profilePicture;

  @override
  Widget build(BuildContext context) {
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
                // Your save logic here
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 0.1,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
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
                  bottom: 0
                  ,
                  right: 0,
                  child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3.5,
                      color: Theme.of(context).scaffoldBackgroundColor
                      
                    ),
                    color: Color(0xFF835DF1)
                  ),
                  child: Icon(Icons.edit, color:Color.fromARGB(255, 255, 255, 255) ,),
                ))
              ],
            ),
            SizedBox(height: 5.h,),
            TextFormField(
              
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: 'Name',
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Name',
                hintStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold,
                  color: Colors.black,

                )

              ),
            )
          ],
        ),
      ),
    );
  }
}
