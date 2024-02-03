import 'package:flutter/material.dart';

class ShowSnackBar {
  _showSnackBar(BuildContext context,String message, Color background){
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        backgroundColor: background,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

   showSnackBar(BuildContext context,String message, Color background){
    _showSnackBar(context,message, background);
   }
} 