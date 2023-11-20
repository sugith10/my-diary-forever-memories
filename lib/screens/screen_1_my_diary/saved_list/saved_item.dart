import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  final SavedList savedList;

  const SavedItems({required this.savedList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
        bottom: const BottomBorderWidget(),
      ),
      body: Container(
        // Access savedList here and use its properties
        child: Center(child: Text(savedList.listName)),
      ),
    );
  }
}
