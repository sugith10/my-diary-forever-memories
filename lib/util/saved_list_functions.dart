import 'package:diary/db/hive_savedlist_db_ops.dart';
import 'package:flutter/material.dart';

import 'package:diary/models/savedlist_db_model.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

class SavedScreenFunctions{

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

  void showCreateListDialog(BuildContext context){
    _showCreateListDialog(context);
  }

  Future<dynamic> _displayBottomSheet(BuildContext context, String entryId) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Column(
         mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 10.w,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black, // Change the color as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text('Save diary to...', style: TextStyle(fontSize: 17.sp)),
                const Spacer(),
                InkWell(
                  onTap: () {
                     SavedScreenFunctions().showCreateListDialog(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          ValueListenableBuilder(
            valueListenable:
                Hive.box<SavedList>('_savedListBoxName').listenable(),
            builder: (context, box, child) {
              List<SavedList> savedList = box.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: savedList.length,
                itemBuilder: (context, index) {
                  String listName = savedList[index].listName;
                  String listId = savedList[index].id;
                  bool _isChecked = false;
                  return InkWell(
                    onTap: () {
                      print(listId);
                      print(entryId);
                      SavedListDbFunctions()
                          .addMapToDiaryEntryIds(listId, entryId);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: _isChecked,
                                onChanged: (bool? newValue) {}),
                            Text(
                              listName,
                              style: TextStyle(fontSize: 16.5.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(
            thickness: 1.5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  const Icon(Icons.check_rounded),
                  SizedBox(
                    width: 9.sp,
                  ),
                  Text(
                    'Done',
                    style: TextStyle(fontSize: 16.5.sp),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

   Future<void> displayBottomSheet(BuildContext context, String entryId) async {
    await _displayBottomSheet(context, entryId);
  }
}