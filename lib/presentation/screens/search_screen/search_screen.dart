import 'package:diary/models/diary_entry.dart';
import 'package:diary/presentation/screen_transitions/bottom_to_top.dart';
import 'package:diary/presentation/screens/widget/back_button.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/screens/my_diary_screen/widget/dairy_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:diary/presentation/screens/individual_diary_screen/individual_diary_page.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    return Scaffold(
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
         
          style: const TextStyle(fontSize: 20),
          textCapitalization: TextCapitalization.sentences,
        ),
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Image.asset(
                'assets/images/empty_area/search_not_found_2.png',
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final entry = searchResults[index];
                      return InkWell(
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
