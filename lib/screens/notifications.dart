import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      appBar: AppBar(),
       body: Center(
          child: Container(
            width: 100, // Set the width of the Container
            height: 100, // Set the height of the Container
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Makes the Container circular
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2.0, // Border width
              ),
            ),
          ))
    )
    );
  }
}