import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/saved_list_screen/saved_item_screen.dart';
import 'package:diary/screens/widget/appbar_titlestyle.dart';
import 'package:diary/screens/widget/back_button.dart';
import 'package:diary/screens/widget/appbar_bottom.dart';
import 'package:diary/util/saved_list_functions.dart';
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
                SavedScreenFunctions().showCreateListDialog(context);
              },
              icon: const Icon(
                Icons.add,
              
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
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
              ),
              itemCount: savedLists.length,
              itemBuilder: (BuildContext context, int index) {
                final savedList = savedLists[index];
                return Column(
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
