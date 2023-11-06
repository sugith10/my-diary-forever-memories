import 'package:diary/db/hive_operations.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/screens/screen1_my_diary/diary.dart';
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

class MyDiaryScreen extends StatelessWidget {
  const MyDiaryScreen({Key? key}) : super(key: key);

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
              onPressed: () {},
              icon: const Icon(Ionicons.bookmarks_outline, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(1, 0, 0, 5),
                  items: <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: 'item1',
                      child: Text('Newest First'),
                    ),
                    PopupMenuItem(
                      value: 'item2',
                      child: Text('Oldest First'),
                    ),
                  ],
                ).then((value) {
                  if (value == 'item1') {
                    // Handle item1
                  } else if (value == 'item2') {
                    // Handle item2
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
        body: ValueListenableBuilder(
          valueListenable: Hive.box<DiaryEntry>('_boxName').listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final data = value.values.toList()[index];
                return DiaryEntryCard(data);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final changer = Provider.of<Changer>(context, listen: false);

           
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftJoined,
                    child: CreatePage(
                      changer: changer,
                    ),
                    childCurrent: this));
          },
          backgroundColor: Color.fromARGB(255, 150, 186, 222),
          child: const Icon(Icons.create_outlined),
        ),
      ),
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final DiaryEntry entry;

  DiaryEntryCard(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key:  ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane:  ActionPane(
        motion: BehindMotion(),
      dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed:(context) => deleteDiaryEntry(entry, context),

            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: InkWell(
        onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> DiaryDetailPage(entry: entry,)));
        },
        child: Padding(
          padding:  EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Container(
            padding:  EdgeInsets.all(16.0),
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
                Row(
                  children: [
                    Text(
                      entry.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),Spacer(),
                     InkWell(child: Icon(Icons.delete), onTap: () {
                        if (entry.id != null) {
    DbFunctions().deleteDiary(entry.id!); // Pass the entry's id to delete
  }
                      
                     },)
                  ],
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
                    // You can add additional icons or buttons here if needed
                    // For example, an edit button or a delete button
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

void deleteDiaryEntry(DiaryEntry entry, BuildContext context) async {
 
    final dbFunctions = DbFunctions();
    await dbFunctions.deleteDiary(entry.id!); // Delete from Hive box
    dbFunctions.diaryEntryNotifier.remove(entry); // Remove from local list
    diaryEntriesNotifier.notifyListeners(); // Notify listeners
}
