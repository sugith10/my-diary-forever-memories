import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MySearchAppBar extends StatefulWidget {
  @override
  _MySearchAppBarState createState() => _MySearchAppBarState();
}

class _MySearchAppBarState extends State<MySearchAppBar> {
  TextEditingController _searchController = TextEditingController();

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("Your content goes here"),
              ),
            ),
          ],
        ),
       )
    );
  }
}