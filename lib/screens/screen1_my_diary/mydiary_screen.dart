import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen1_my_diary/diary.dart';
import 'package:diary/screens/screen1_my_diary/watchlist.dart';
import 'package:diary/screens/screen2_calendar/provider_calendar.dart';
import 'package:diary/screens/screen5_create/create_page.dart';
import 'package:diary/screens/screen1_my_diary/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

  @override
  State<MyDiaryScreen> createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  
  String selectedSortOption = 'Newest First';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Diary', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MySearchAppBar()));
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: WatchList()));
              },
              icon: const Icon(Ionicons.bookmarks_outline, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(1, 0, 0, 5),
                  items: <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: 'Newest First',
                      child: Text('Newest First'),
                    ),
                    const PopupMenuItem(
                      value: 'Oldest First',
                      child: Text('Oldest First'),
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
                  }
                });
              },
              icon: const Icon(Ionicons.ellipsis_vertical_outline,
                  color: Colors.black),
            ),
          ],
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
              builder: (context, value, child) {
                var sortedEntries = value.values.toList();
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

                return ListView.builder(
                  itemCount: sortedEntries.length,
                  itemBuilder: (context, index) {
                    final data = sortedEntries[index];
                    return DiaryEntryCard(data, index);
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final changer = Provider.of<Changer>(context, listen: false);
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.rightToLeftJoined,
            //         child: CreatePage(
            //           changer: changer,
            //         ),
            //         childCurrent: this));
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePage(
                      changer: changer,
                    )));
          },
          backgroundColor: Color.fromARGB(255, 255, 254, 254),
          child: customIcon(),
          elevation: 3,
        ),
      ),
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final int index;

  DiaryEntryCard(this.entry, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(0),

      
      startActionPane: ActionPane(
        
        motion: const ScrollMotion(),

       
        dismissible: DismissiblePane(onDismissed: () {}),

      
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
        motion: BehindMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            
            onPressed: (context) => deleteDiaryEntry(entry),

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
      ),
    );
  }
}

void doNothing(BuildContext context) {}

void deleteDiaryEntry(DiaryEntry entry) async {
  if (entry.id != null) {
    DbFunctions().deleteDiary(entry.id!);
  }
  print(entry.id);
}

Widget customIcon() {
  return Image.asset(
    'images/start_writing.png',
    width: 40,
    height: 40,
  );
}

