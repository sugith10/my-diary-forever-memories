import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
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
       
      ),
    );
  }
}
