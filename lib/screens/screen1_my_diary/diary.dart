import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:ionicons/ionicons.dart';

class DiaryDetailPage extends StatelessWidget {
  final DiaryEntry entry;

  DiaryDetailPage({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove app bar shadow
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
              child: Text(
                entry.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                entry.date.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Twitter gray color
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
        label: Text(
          'Delete',
          style: TextStyle(color: Colors.white),
        ),
      )
    
      );
      
    
  }
}
