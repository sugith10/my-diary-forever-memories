import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  const SavedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.abc),
        title: Text('Saved Items'),
        bottom:  BottomBorderWidget(),
      ),

    );
  }
}