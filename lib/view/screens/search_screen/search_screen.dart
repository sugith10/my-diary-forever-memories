import 'package:diary/model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/core/utils/screen_transitions/bottom_to_top.dart';
import 'package:diary/view/screens/widget/back_button.dart';
import 'package:diary/view/screens/widget/appbar_bottom_common.dart';
import 'package:diary/view/screens/my_diary_screen/widget/diary_card_widget/dairy_card.dart';
import 'package:flutter/material.dart';

import 'package:diary/view/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButtonWidget(),
        title: TextField(
          controller: _searchController,
          onChanged: (query) {
            _searchDiaryEntries(query);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 16.sp),
            border: InputBorder.none,
          ),
          cursorColor: const Color.fromARGB(115, 95, 95, 95),
         
          style: const TextStyle(fontSize: 20),
          textCapitalization: TextCapitalization.sentences,
        ),
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Image.asset(
                'assets/images/empty_area/search_not_found_2.png',
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
                          Navigator.push(context, bottomToTop( DiaryDetailPage(
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
