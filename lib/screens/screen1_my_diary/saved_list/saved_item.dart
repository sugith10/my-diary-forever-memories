import 'package:diary/screens/widgets/back_button.dart';
import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatelessWidget {
  const SavedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        elevation: 0,
        bottom:  const BottomBorderWidget(),
      ),
      body: Container(
        
      ),
    );
  }
}