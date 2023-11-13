import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),
              
        ),
        title: Text('Saved', style: TextStyle(color: Colors.black, fontSize: 17.sp),),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black, size: 32,))
        ],
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
    );
  }
}
