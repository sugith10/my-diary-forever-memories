import 'package:diary/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        
        // leading: Text('Hi ${'User Name'}', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              onPressed: () {
                _showPopupDialog(context);
              },
              icon: Icon(
                Icons.power_settings_new_outlined,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: const Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/profile.png',
                    ),
                    backgroundColor: Color(0xFFF1F5FF),
                    maxRadius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'user email',
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child: Icon(Icons.notifications_none,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    color: Colors
                        .transparent,
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFF1F5FF),
                            child: Icon(Ionicons.color_palette_outline,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text('Customization', style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFF1F5FF),
                        child: Icon(Icons.backup_outlined, color: Colors.black),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text('Backup', style: TextStyle(fontSize: 17))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFF1F5FF),
                        child: Icon(Icons.restore, color: Colors.black),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text('Restore', style: TextStyle(fontSize: 17))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFF1F5FF),
                        child:
                            Icon(Icons.feedback_outlined, color: Colors.black),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text('Feedback', style: TextStyle(fontSize: 17))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

void _showPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Logout Confirmation',
          style: TextStyle(
            fontSize: 27,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/onboarding');
            },
          ),
        ],
      );
    },
  );
}
