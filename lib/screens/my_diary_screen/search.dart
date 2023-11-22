import 'package:diary/screens/widget/back_button.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:page_transition/page_transition.dart';
import 'package:diary/screens/individual_diary_screen/diary.dart';
import 'package:sizer/sizer.dart';

class MySearchAppBar extends StatefulWidget {
  @override
  _MySearchAppBarState createState() => _MySearchAppBarState();
}

class _MySearchAppBarState extends State<MySearchAppBar> {
  final TextEditingController _searchController = TextEditingController();
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
          leading: const BackButtonWidget(),
          title: TextField(
            controller: _searchController,
            onChanged: (query) {
              searchDiaryEntries(query);
            },
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(fontSize: 16.sp),
              border: InputBorder.none,
            ),
            cursorColor: const Color.fromARGB(115, 95, 95, 95),
            cursorHeight: 22,
            style: const TextStyle(fontSize: 20),
            textCapitalization: TextCapitalization.sentences,
          ),
          elevation: 0,
          bottom: const BottomBorderWidget()
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
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
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
