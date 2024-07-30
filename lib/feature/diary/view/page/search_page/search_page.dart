import 'package:diary/core/util/asset_path/app_png.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import '../../../../../core/model/diary_model/diary_model.dart';
import '../../../../../core/route/page_transition/bottom_to_top.dart';
import '../../../../home/widget/diary_card_widget/dairy_card.dart';
import '../individual_diary_page.dart';
import 'widget/search_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final Box<DiaryModel> _diaryBox = Hive.box<DiaryModel>('DiaryModelBox');
  List<DiaryModel> _searchResults = [];

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchTextField(
          controller: _searchController,
          onChanged: (query) {
            _searchDiaryEntries(query);
          },
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
                            bottomToTop(
                              ViewDiaryPage(
                                entry: entry,
                              ),
                            ),
                          );
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
