import 'package:diary/data/model/hive/savedlist_db_model/savedlist_db_model.dart';
import 'package:diary/view/route/page_transition/scale.dart';
import 'package:diary/view/util/saved_list_functions.dart';
import 'package:diary/utils/assets/app_png.dart';
import 'package:diary/view/components/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';


import '../../components/app_custom_app_bar.dart';
import '../saved_list_screen/saved_item_screen/saved_item_screen.dart';

class SavedListScreen extends StatelessWidget {
  const SavedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:const Text("Saved List"),
        children: [
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<SavedList>('savedListBoxName').listenable(),
          builder: (context, Box<SavedList> box, child) {
            final List<SavedList> savedLists = box.values.toList();
            if (savedLists.isEmpty) {
              return const EmptyWidget(
                image: AppPng.emptyList,
                message: "Don't wait create a saved list.",
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
