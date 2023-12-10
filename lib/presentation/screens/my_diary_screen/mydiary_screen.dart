import 'dart:developer';
import 'package:diary/core/models/diary_entry.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/screens/saved_list_screen/saved_list_screen.dart';
import 'package:diary/infrastructure/providers/provider_calendar.dart';
import 'package:diary/presentation/screens/create_screen/create_page.dart';
import 'package:diary/presentation/screens/search_screen/search_screen.dart';
import 'package:diary/presentation/screens/widget/appbar_bottom_common.dart';
import 'package:diary/presentation/screens/widget/custom_icon_common.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:diary/presentation/util/my_diary_scren_functions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({super.key});

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  String selectedSortOption = 'Newest First';
  DateTimeRange? selectedDateRange;

  List<DiaryEntry> filterEntriesByDateRange(
      List<DiaryEntry> entries, DateTimeRange dateRange) {
    print('filter function added');
    return entries
        .where((entry) =>
            entry.date.isAfter(dateRange.start) &&
            entry.date.isBefore(dateRange.end))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isFabVisible = true;
    return SafeArea(
      child: Scaffold(
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context)
                .copyWith(physics: const BouncingScrollPhysics()),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'My ',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Diary',
                          style: TextStyle(
                            color: const Color(0xFF835DF1),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const MySearchAppBar(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: const SavedListScreen()));
                      },
                      icon: const Icon(
                        Ionicons.bookmarks_outline,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(1, 0, 0, 5),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : AppColor.showMenuDark.color,
                          items: <PopupMenuEntry>[
                            const PopupMenuItem(
                              value: 'Newest First',
                              child: Text('Newest First'),
                            ),
                            const PopupMenuItem(
                              value: 'Oldest First',
                              child: Text('Oldest First'),
                            ),
                            const PopupMenuItem(
                              value: 'Range Pick',
                              child: Text('Range Pick'),
                            ),
                          ],
                        ).then((value) async {
                          if (value == 'Newest First') {
                            setState(() {
                              selectedSortOption = value as String;
                            });
                          } else if (value == 'Oldest First') {
                            setState(() {
                              selectedSortOption = value as String;
                            });
                          } else if (value == 'Range Pick') {
                            selectedDateRange = await MyDiaryScreenFunctions()
                                .handleDateRangePick(context);
                            if (selectedDateRange != null) {
                              selectedSortOption = value as String;
                              print('the new range = $selectedDateRange');
                            } else {
                              setState(() {
                                selectedSortOption = value as String;
                              });
                              print('date range is null');
                            }
                          }
                        });
                      },
                      icon: const Icon(
                        Ionicons.ellipsis_vertical_outline,
                      ),
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
                      Hive.box<DiaryEntry>('_boxName').listenable(),
                  builder: (context, box, child) {
                    var sortedEntries = box.values.toList();
                    switch (selectedSortOption) {
                      case 'Newest First':
                        sortedEntries.sort((a, b) => b.date.compareTo(a.date));
                        break;
                      case 'Oldest First':
                        sortedEntries.sort((a, b) => a.date.compareTo(b.date));
                        break;
                      case 'Range Pick':
                        if (selectedDateRange != null) {
                          log('range pick - in value listenable builder');
                          sortedEntries = filterEntriesByDateRange(
                              sortedEntries, selectedDateRange!);
                        }
                        break;
                      default:
                        sortedEntries.sort((a, b) => b.date.compareTo(a.date));
                        break;
                    }
                    Map<String, List<DiaryEntry>> groupedEntries = {};
                    for (var entry in sortedEntries) {
                      final dateKey = DateFormat('y-MM-dd').format(entry.date);
                      groupedEntries.putIfAbsent(dateKey, () => []);
                      groupedEntries[dateKey]!.add(entry);
                    }
                    log('Grouped Entries Length: ${groupedEntries.length}');
                    if (sortedEntries.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/images/empty_area/entry_not_found.png'),
                              const Text(
                                'Capture the beauty of your memories',
                                style: TextStyle(fontSize: 20),
                              ),
                              const Text(
                                'Never lose, always record.',
                                style: TextStyle(
                                    fontSize: 20,
                                 ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index >= groupedEntries.length) {
                            log('Index out of bounds: $index');
                            return const SizedBox();
                          }
                          final dateKey = groupedEntries.keys.toList()[index];
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
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              final changer = Provider.of<Changer>(context, listen: false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateDiaryScreen(
                      changer: changer,
                      selectedColor: GetColors().getThemeColor(context)),
                ),
              );
            },
            elevation: 3,
            child: const CustomIconWidget(),
          )),
    );
  }
}
