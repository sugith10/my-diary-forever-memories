import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),
        ),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 0.1,
              )),
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 28),
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(

              decoration: InputDecoration(
                  hintText: 'Start typing here',
                  hintStyle: TextStyle(fontSize: 18),
                   border: InputBorder.none, ),
                    cursorColor: Colors.red, // Customize the cursor color
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    ));
  }
}
