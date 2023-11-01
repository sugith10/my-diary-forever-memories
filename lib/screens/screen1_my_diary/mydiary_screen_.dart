import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/create_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryEntryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Entries', style: TextStyle(color: Colors.black)),
      ),
      body: Consumer<DiaryEntryProvider>(
        builder: (context, diaryEntryProvider, child) {
          final List<DiaryEntry> diaryEntries = diaryEntryProvider.diaryEntries;

          if (diaryEntries == null) {
            // Loading state
            return Center(child: CircularProgressIndicator());
          } else if (diaryEntries.isEmpty) {
            // No data available
            return Center(child: Text('No diary entries available.'));
          } else {
            // Data available
            return ListView.builder(
              itemCount: diaryEntries.length,
              itemBuilder: (context, index) {
                final entry = diaryEntries[index];
                return ListTile(
                  title: Text(entry.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${entry.date.toString()}'), // Display the date
                      Text('Content: ${entry.content}'), // Display the content
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final changer = Provider.of<Changer>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(changer: changer),
            ),
          );
        },
        child: Icon(Icons.create_outlined),
        backgroundColor: Color(0xFF5B6ABF).withOpacity(0.7),
      ),
    );
  }
}
