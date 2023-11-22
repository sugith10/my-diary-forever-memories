import 'dart:developer';
import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/individual_diary_screen/diary.dart';
import 'package:diary/screens/my_diary_screen/saved_list_screen/saved_list.dart';
import 'package:diary/providers/provider_calendar.dart';
import 'package:diary/screens/create_screen/create_page.dart';
import 'package:diary/screens/my_diary_screen/search.dart';
import 'package:diary/screens/widget/bottomborder.dart';
import 'package:diary/screens/widget/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  String selectedSortOption = 'Newest First';
  @override
  Widget build(BuildContext context) {
    bool isFabVisible = true;
    return SafeArea(
      child: Scaffold(
        //  floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context)
              .copyWith(physics: const BouncingScrollPhysics()),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                title:  RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children:  <TextSpan>[
        TextSpan(
          text: 'My ',
          style: TextStyle( fontFamily: 'SFPRO',
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 15.sp,
        fontWeight: FontWeight.w600, 
          ),
        ),
        TextSpan(
          text: 'Diary',
          style: TextStyle(
            fontFamily: 'SFPRO',
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
                          child: MySearchAppBar(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.topToBottom,
                              child: const SavedListScreen()));
                    },
                    icon: const Icon(Ionicons.bookmarks_outline,
                        color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(1, 0, 0, 5),
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
                      ).then((value) {
                        if (value == 'Newest First') {
                          setState(() {
                            selectedSortOption = value as String;
                          });
                        } else if (value == 'Oldest First') {
                          setState(() {
                            selectedSortOption = value as String;
                          });
                        } else if (value == 'Range Pick') {
                          handleDateRangePick(context);
                        }
                      });
                    },
                    icon: const Icon(Ionicons.ellipsis_vertical_outline,
                        color: Colors.black),
                  ),
                ],
                bottom: const BottomBorderWidget(),
                elevation: 0,
                pinned: false, // Keep the app bar pinned
                floating: true, // Make the app bar float
                snap: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<DiaryEntry>('_boxName').listenable(),
                  builder: (context, box, child) {
                    var sortedEntries = box.values.toList();
                    //  print('Sorted Entries Length: ${sortedEntries.length}');
                    switch (selectedSortOption) {
                      case 'Newest First':
                        sortedEntries.sort((a, b) => b.date.compareTo(a.date));
                        break;
                      case 'Oldest First':
                        sortedEntries.sort((a, b) => a.date.compareTo(b.date));
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

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index >= groupedEntries.length) {
                            log('Index out of bounds: $index');
                            return const SizedBox();
                          }
                          final dateKey = groupedEntries.keys.toList()[index];
                          final entries = groupedEntries[dateKey]!;
                          return buildGroupedDiaryEntries(entries, dateKey);
                        },
                        childCount: sortedEntries.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: isFabVisible ? FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            final changer = Provider.of<Changer>(context, listen: false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePage(
                  changer: changer,
                ),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 255, 254, 254),
          elevation: 3,
          child: const CustomIconWidget(),
        // ignore: dead_code
        ) : null,
      ),
    );
  }

  Widget buildGroupedDiaryEntries(List<DiaryEntry> entries, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date,
            style: const TextStyle(
              // fontWeight: FontWeight.normal,
              fontSize: 15.0,
            ),
          ),
        ),
        Column(
          children: entries.map((entry) {
            return DiaryEntryCard(entry, entries.indexOf(entry),
                key: ValueKey(entry.id));
          }).toList(),
        ),
      ],
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final int index;

  const DiaryEntryCard(this.entry, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          // print('Start Action Dismissed');
        }),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          if (entry.id != null) {
            DbFunctions().deleteDiary(entry.id!);
            //  diaryEntriesNotifier.notifyListeners();
          } else {
            // print('no data found');
          }
        }),
        children: const [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=> DiaryDetailPage(entry: entry,)));
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.bottomCenter,
                  child: DiaryDetailPage(
                    entry: entry,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.title,
                        style: TextStyle(
                            fontSize: 15.sp,
                            // fontFamily: "Satoshi",

                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.sp),
                Text(entry.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color.fromARGB(255, 105, 105, 105)),
                    textAlign: TextAlign.justify),
                SizedBox(height: 5.sp),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

Future<void> handleDateRangePick(BuildContext context) async {
  final DateTimeRange? pickedDateRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().day),
    lastDate: DateTime.now(),
    locale: Localizations.localeOf(context),
    saveText: 'Done',
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF835DF1)),
        ),
        child: child ?? Container(),
      );
    },
  );

  if (pickedDateRange != null) {
    final startDate = pickedDateRange.start;
    final endDate = pickedDateRange.end;
    final formattedStartDate = DateFormat('d MMMM, y').format(startDate);
    final formattedEndDate = DateFormat('d MMMM, y').format(endDate);

    print('Selected date range: ${formattedStartDate} - ${formattedEndDate}');
  }
}