import 'package:flutter/material.dart';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';

class DiaryDetailPage extends StatelessWidget {
  final DiaryEntry entry;

  DiaryDetailPage({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove app bar shadow
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.blue), // Twitter blue color
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      ),
    );
  }
}
