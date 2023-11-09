import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:page_transition/page_transition.dart';
import 'package:diary/screens/screen1_my_diary/diary.dart';

class MySearchAppBar extends StatefulWidget {
  @override
  _MySearchAppBarState createState() => _MySearchAppBarState();
}

class _MySearchAppBarState extends State<MySearchAppBar> {
  TextEditingController _searchController = TextEditingController();
  final Box<DiaryEntry> diaryBox = Hive.box<DiaryEntry>('_boxName');
  List<DiaryEntry> searchResults = [];

  void searchDiaryEntries(String query) {
  query = query.toLowerCase();
  if (query.isEmpty) {
    setState(() {
      searchResults = [];
    });
  } else {

    setState(() {
      searchResults = diaryBox.values.where((entry) {
        return entry.title.toLowerCase().contains(query);
      }).toList();
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Ionicons.chevron_back_outline,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          title: TextField(
            controller: _searchController,
            onChanged: (query) {
              searchDiaryEntries(query);
            },
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(fontSize: 20),
              border: InputBorder.none,
            ),
            cursorColor: Color.fromARGB(115, 95, 95, 95),
            cursorHeight: 22,
            style: TextStyle(fontSize: 20),
            textCapitalization: TextCapitalization.sentences,
          ),
          elevation: 0,
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final entry = searchResults[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: DiaryDetailPage(
                            entry: entry,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.title,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              entry.content,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('d MMMM, y').format(entry.date),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
