import 'package:diary/screens/notifications.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: Center(
            child: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          IconButton(
              onPressed: () {},
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                               
                      },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFF1F5FF),
                          child:
                              Icon(Icons.notifications_none, color: Colors.black),
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
                    color: Colors.transparent, // You can set a different color here if needed
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFF1F5FF),
                            child: Icon(Icons.settings, color: Colors.black),
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
