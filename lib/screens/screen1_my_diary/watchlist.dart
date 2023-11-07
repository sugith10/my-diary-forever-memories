import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon( Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),),
         
      ),
    );
  }
}