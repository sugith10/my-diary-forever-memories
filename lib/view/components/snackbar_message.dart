import 'package:flutter/material.dart';


class  SnackBarMessage {
  final String message;
  final Color color;

  SnackBarMessage({required this.message, required this.color});

   _scaffoldMessenger(BuildContext context){
    return ScaffoldMessenger.of( context).showSnackBar(
      
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                backgroundColor: color,
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
