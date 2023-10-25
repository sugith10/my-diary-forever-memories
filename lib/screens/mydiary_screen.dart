import 'package:diary/screens/create_page.dart';
import 'package:flutter/material.dart';

class MyDiaryScreen extends StatelessWidget {
  const MyDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (AppBar(
         
           automaticallyImplyLeading: false,
           title: (Text('My Diary',style: TextStyle(color: Colors.black),)),
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
        )),

        body: Container(
          child: Column(
            children: [

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreatePage(),
                                ),
                              );
        }, child: Icon(Icons.create_outlined)),
      ),
    );
  }
}