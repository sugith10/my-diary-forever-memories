import 'package:diary/config/hive_box_name.dart';
import 'package:diary/data/model/hive/hive_db_model/diary_entry_db_model/diary_entry.dart';
import 'package:diary/presentation/navigation/screen_transitions/no_movement.dart';
import 'package:diary/presentation/util/my_diary_scren_functions.dart';
import 'package:diary/presentation/providers/my_diary_scrn_prvdr.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../../theme/app_color.dart';
import '../saved_list_page/saved_list_page.dart';
import '../search_screen/search_screen.dart';
import '../widget/appbar_bottom_common.dart';
import 'widget/diary_card_widget/my_diary_title.dart';
import 'widget/fab_widget/fab_widget.dart';
import 'widget/no_diaries_widget.dart';
import 'widget/popup_menu_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedSortOption = 'Newest First';

  List<DiaryEntry> filterEntriesByDateRange(
      List<DiaryEntry> entries, DateTimeRange dateRange) {
    return entries
        .where((entry) =>
            entry.date.isAfter(dateRange.start) &&
            entry.date.isBefore(dateRange.end))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyDiaryScreenProvider>(
      create: (context) => MyDiaryScreenProvider(),
      child: Consumer<MyDiaryScreenProvider>(
        builder: (context, myDiaryScreenProvider, child) {
          return SafeArea(
            child: Scaffold(
              body: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(physics: const BouncingScrollPhysics()),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      title: const MyDiaryTitle(),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(noMovement(const SearchPage()));
                          },
                          icon: const Icon(IconlyLight.search),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(noMovement(const SavedListScreen()));
                            },
                            icon: const Icon(IconlyLight.bookmark)),
                        IconButton(
                          onPressed: () async {
                            showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(1, 0, 0, 5),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : AppColor.showMenuDark.color,
                              items: <PopupMenuEntry>[
                                const PopupMenuItem(
                                  value: 'Newest First',
                                  child: PopUpMenuText(title: 'Newest First'),
                                ),
                                const PopupMenuItem(
                                  value: 'Oldest First',
                                  child: PopUpMenuText(title: 'Oldest First'),
                                ),
                                const PopupMenuItem(
                                  value: 'Range Pick',
                                  child: PopUpMenuText(title: 'Range Pick'),
                                ),
                              ],
                            ).then((value) async {
                              if (value == 'Newest First' ||
                                  value == 'Oldest First') {
                                setState(() {
                                  selectedSortOption = value as String;
                                });
                              } else if (value == 'Range Pick') {
                                final selectedDateRange =
                                    await MyDiaryScreenFunctions()
                                        .handleDateRangePick(context);

                                myDiaryScreenProvider
                                    .setSelectedDateRange(selectedDateRange);

                                if (selectedDateRange != null) {
                                  selectedSortOption = value as String;
                                } else {
                                  setState(() {
                                    selectedSortOption = value as String;
                                  });
                                }
                              }
                            });
                          },
                          icon: const Icon(IconlyLight.filter),
                        ),
                      ],
                      bottom: const BottomBorderWidget(),
                      elevation: 0,
                      pinned: false,
                      floating: true,
                      snap: true,
                    ),
                    ValueListenableBuilder(
                      valueListenable:
                          Hive.box<DiaryEntry>(HiveBoxName.diaryBox).listenable(),
                      builder: (context, box, child) {
                        var sortedEntries = box.values.toList();
                        switch (selectedSortOption) {
                          case 'Newest First':
                            sortedEntries
                                .sort((a, b) => b.date.compareTo(a.date));
                            break;
                          case 'Oldest First':
                            sortedEntries
                                .sort((a, b) => a.date.compareTo(b.date));
                            break;
                          case 'Range Pick':
                            if (myDiaryScreenProvider.selectedDateRange !=
                                null) {
                              sortedEntries = filterEntriesByDateRange(
                                  sortedEntries,
                                  myDiaryScreenProvider.selectedDateRange!);
                            }
                            break;
                          default:
                            sortedEntries
                                .sort((a, b) => b.date.compareTo(a.date));
                            break;
                        }
                        Map<String, List<DiaryEntry>> groupedEntries = {};
                        for (var entry in sortedEntries) {
                          final dateKey =
                              DateFormat('y-MM-dd').format(entry.date);
                          groupedEntries.putIfAbsent(dateKey, () => []);
                          groupedEntries[dateKey]!.add(entry);
                        }

                        if (sortedEntries.isEmpty) {
                          return const SliverFillRemaining(
                            child: Center(
                              child: NoDiaries(),
                            ),
                          );
                        }
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index >= groupedEntries.length) {
                                return const SizedBox();
                              }
                              final dateKey =
                                  groupedEntries.keys.toList()[index];
                              final entries = groupedEntries[dateKey]!;
                              return MyDiaryScreenFunctions()
                                  .buildGroupedDiaryEntries(entries, dateKey);
                            },
                            childCount: sortedEntries.length,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: const CreatePageFAB(),
            ),
          );
        },
      ),
    );
  }
}
