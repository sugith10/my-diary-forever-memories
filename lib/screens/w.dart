import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    double displayWidth = MediaQuery.of(context).size.width;
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

        //  bottomNavigationBar: GoogleKeepBottomNavigationBar(),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(displayWidth * .05),
          height: displayWidth * .155,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 38,
                    offset: Offset(0, 10))
              ],
              borderRadius: BorderRadius.circular(50)),
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        HapticFeedback.lightImpact();
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height:
                                index == currentIndex ? displayWidth * .12 : 0,
                            width:
                                index == currentIndex ? displayWidth * .32 : 0,
                            decoration: BoxDecoration(
                                color: index == currentIndex
                                    ? Colors.blueAccent.withOpacity(.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        AnimatedContainer(duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn ,
                        width: index == currentIndex ? displayWidth * .31 : displayWidth * .18,
                        alignment: Alignment.center,
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}

class GoogleKeepBottomNavigationBar extends StatelessWidget {
  const GoogleKeepBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Lists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Images',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.audiotrack),
          label: 'Audio',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.green,
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}