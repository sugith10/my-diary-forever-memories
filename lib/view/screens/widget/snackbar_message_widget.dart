import 'dart:developer';
import 'package:flutter/material.dart';


class  SnackBarMessage {
  final String message;

  SnackBarMessage({required this.message});

   _scaffoldMessenger(BuildContext context){
    log('welcome to message');
    return ScaffoldMessenger.of( context).showSnackBar(
      
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
                content: Center(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
  }

  scaffoldMessenger(BuildContext context){
_scaffoldMessenger(context);
  }
}
