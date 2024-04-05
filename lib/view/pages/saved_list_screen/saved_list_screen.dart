import 'package:diary/core/data/model/hive/hive_database_model/savedlist_db_model/savedlist_db_model.dart';
import 'package:diary/core/presentation/utils/screen_transitions/scale.dart';
import 'package:diary/view/pages/saved_list_screen/saved_item_screen/saved_item_screen.dart';
import 'package:diary/view/pages/widget/not_found.dart';
import 'package:diary/view/pages/widget/appbar_titlestyle_common.dart';
import 'package:diary/view/pages/widget/appbar_bottom_common.dart';
import 'package:diary/view/pages/widget/back_button.dart';
import 'package:diary/view/util/saved_list_functions.dart';
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
            ),
          )
        ],
        bottom: const BottomBorderWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable:
              Hive.box<SavedList>('savedListBoxName').listenable(),
          builder: (context, Box<SavedList> box, child) {
            final List<SavedList> savedLists = box.values.toList();
            if (savedLists.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_area/savedlist_not_found.png.png',
                  ),
                  const NotFound(
                    message: "Don't wait create a saved list.",
                  ),
                ],
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
              ),
              itemCount: savedLists.length,
              itemBuilder: (BuildContext context, int index) {
                final savedList = savedLists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SizeTransitionPageRoute(
                        child: SavedItems(savedList: savedList),
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 212, 212),
                            borderRadius: BorderRadius.circular(8)),
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
