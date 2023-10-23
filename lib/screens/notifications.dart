import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your NotificationPage content goes here
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon( Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),),
         
          title: Text(
            'Notification Page',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.0,
                color: Colors.black,
              ),
              
            ),
            
            alignment: Alignment.center,
            child: Icon(Ionicons.chevron_back_outline),
          ),
        ),
      ),
    );
  }
}
