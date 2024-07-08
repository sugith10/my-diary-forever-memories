import 'package:diary/utils/assets/app_png.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/adapters.dart';


import '../../../data/model/hive/diary_entry_db_model/diary_entry.dart';
import '../../route/page_transition/bottom_to_top.dart';
import '../../components/app_custom_app_bar.dart';
import '../home_page/widget/diary_card_widget/dairy_card.dart';
import '../individual_diary_page/individual_diary_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final Box<DiaryEntry> _diaryBox = Hive.box<DiaryEntry>('diaryEntryBox');
  List<DiaryEntry> _searchResults = [];

  void _searchDiaryEntries(String query) {
    query = query.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
    } else {
      setState(() {
        _searchResults = _diaryBox.values.where((entry) {
          return entry.title.toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (query) {
            _searchDiaryEntries(query);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 16.sh),
            border: InputBorder.none,
          ),
          cursorColor: const Color.fromARGB(115, 95, 95, 95),
          style: const TextStyle(fontSize: 20),
          textCapitalization: TextCapitalization.sentences,
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Image.asset(
                AppPng.searchPageIntro,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final entry = _searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              bottomToTop(DiaryDetailPage(
                                entry: entry,
                              )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: DiaryCardView(
                            entry: entry,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
