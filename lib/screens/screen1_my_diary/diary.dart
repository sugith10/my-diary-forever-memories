import 'dart:io';

import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class DiaryDetailPage extends StatelessWidget {
  final DiaryEntry entry;

  DiaryDetailPage({required this.entry, Key? key}) : super(key: key);

   void _showOriginalImage(BuildContext context) {
    if (entry.imagePath != null) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Image.file(
              File(entry.imagePath!),
              fit: BoxFit.contain,
            ),
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, 
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),
          actions: [
           
           IconButton(onPressed: (){},  icon: const Icon(Ionicons.ellipsis_vertical_outline,
                  color: Colors.black),)
          ],
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
      body: ListView(
        children: 
           [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    entry.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                       Text(
                        DateFormat('d MMMM,y').format(entry.date),
              
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey, 
              ),
            ),
                ],
              ),
            ),
             if (entry.imagePath != null)
            GestureDetector(
               onTap: () {
                _showOriginalImage(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                   borderRadius: BorderRadius.circular(
                        10), 
                  child: Image.file(
                    File(entry.imagePath!), 
                    fit: BoxFit.cover,
                    height: 500, 
                  ),
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                entry.content,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
    floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (entry.id != null) {
            DbFunctions().deleteDiary(entry.id!);
          }
          Navigator.pop(context);
        },
        backgroundColor: Colors.red, // Twitter red color
        icon: Icon(Icons.delete, color: Colors.white),
        label: const Text(
          'Delete',
          style: TextStyle(color: Colors.white),
        ),
      )
    
      );
      
    
  }
}
