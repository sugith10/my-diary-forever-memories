import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Ionicons.chevron_back_outline,
                color: Colors.black, size: 25),
          ),
          actions: [
            Center(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ))),
            SizedBox(
              width: 20,
            )
          ],
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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 28),
                border: InputBorder.none,
              ),
              cursorColor: Colors.black,
              cursorHeight: 28,
              textAlignVertical: TextAlignVertical.center,
            ),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                hintText: 'Start typing here',
                hintStyle: TextStyle(fontSize: 18),
                border: InputBorder.none,
              ),
              cursorColor: Colors.red,
              cursorHeight: 13,
              textAlignVertical: TextAlignVertical.center,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType
              .fixed, // Use fixed type to disable animations
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          'images/text.png',
                        ))),
                label: ''),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          'images/smile.png',
                        ))),
                label: ''),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          'images/art-gallery.png',
                        ))),
                label: ''),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          'images/clock.png',
                        ))),
                label: ''),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
