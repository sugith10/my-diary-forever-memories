import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Diary extends StatelessWidget {
   Diary({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        appBar:  AppBar(
          automaticallyImplyLeading: false,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),
          
          elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: Color.fromARGB(255, 0, 0, 0),
        //         width: 0.1,
        //       ),
        //     ),
        //   ),
        // ),
        ),
        
    
          )
    );
  }
}
