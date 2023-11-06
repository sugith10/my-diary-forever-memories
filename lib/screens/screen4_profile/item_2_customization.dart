import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon( Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),),
         
          title: const Text(
            'Cutomization',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
           bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 0.1,
                ),
              ),
            ),
          ),
        ),
       
      ),
    );
  }
}
