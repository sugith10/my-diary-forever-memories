import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (AppBar(
         
           automaticallyImplyLeading: false,
           title: (Text('Gallery',style: TextStyle(color: Colors.black),)),
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
       
      ),
    );
  }
}
