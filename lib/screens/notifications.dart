import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your NotificationPage content goes here
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notification Page'),
        ),
        body: Center(
          child: Text('This is the Notification Page content.'),
        ),
      ),
    );
  }
}