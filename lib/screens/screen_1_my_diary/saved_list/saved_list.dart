import 'package:diary/db/hive_savedlist_db_ops.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/screen_1_my_diary/saved_list/saved_item.dart';
import 'package:diary/screens/widgets/appbar_titlestyle.dart';
import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

class SavedListScreen extends StatelessWidget {
  const SavedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        title: const AppbarTitleWidget(
          text: 'Saved',
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _showCreateListDialog(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 25,
              ))
        ],
        bottom: const BottomBorderWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable:
              Hive.box<SavedList>('_savedListBoxName').listenable(),
          builder: (context, Box<SavedList> box, child) {
            final List<SavedList> savedLists = box.values.toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    2, // You can change the number of columns as needed
                crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                // childAspectRatio: 1.2,
              ),
              itemCount: savedLists.length,
              itemBuilder: (BuildContext context, int index) {
                final savedList = savedLists[index];
                return GestureDetector(
                  onTap: () {
                    // Handle tapping on a specific saved list
                    // You can navigate to another screen or perform actions here
                  },
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SavedItems(savedList: savedList),
                            ),
                          );
                        },
                        child: Container(
                          height: 16.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 213, 212, 212),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Text(
                        savedList.listName,
                        style: const TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void _showCreateListDialog(BuildContext context) {
  TextEditingController listNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Create a Saved List')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: listNameController,
              cursorColor: const Color(0xFF835DF1),
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'List Name',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF835DF1),
                  ),
                ),
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                String listName = listNameController.text;
                if (listName.isNotEmpty) {
                  await SavedListDbFunctions().createSavedList(listName);
                  // Navigator.pop(context); // Close the dialog
                } else {
                  // Show a snackbar or handle the case when the list name is empty
                }
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF835DF1)),
              ),
              child: const Text('Create List'),
            ),
          ],
        ),
      );
    },
  );
}
