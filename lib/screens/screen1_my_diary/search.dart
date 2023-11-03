import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MySearchAppBar extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();
   final GlobalKey<FormFieldState<String>> _searchKey = GlobalKey<FormFieldState<String>>();

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
              icon: const Icon(Ionicons.chevron_back_outline,
                  color: Colors.black, size: 30),
            ),
          ),
          title: TextField(
            controller: _searchController,
             autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
              ),
              cursorColor: Color.fromARGB(115, 95, 95, 95),
              cursorHeight: 22,
              style: TextStyle(fontSize: 20),
              textCapitalization: TextCapitalization.sentences,
          ),
          elevation: 0,
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
        body: const Column(
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