import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline,
              color: Colors.black, size: 30),
              
        ),
        title: Text('Saved', style: TextStyle(color: Colors.black, fontSize: 17.sp),),
        elevation: 0,
        actions: [
<<<<<<< HEAD
          IconButton(onPressed: (){
            _showCreateListDialog(context);
          }, icon: Icon(Icons.add, color: Colors.black, size: 32,))
        ],
        bottom: const BottomBorderWidget(),
        
=======
          IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black, size: 30,))
        ],
        bottom:  const BottomBorderWidget()
>>>>>>> 5d7969395996f0ec0322a5bc2933da2e53486228
      ),
    );
  }
}
<<<<<<< HEAD



 void _showCreateListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create a Saved List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'List Name'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle creating the saved list
                  Navigator.pop(context);
                },
                child: Text('Create List'),
              ),
            ],
          ),
        );
      },
    );
  }


void _solkhowCreateListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create a Saved List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'List Name'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle creating the saved list
                  Navigator.pop(context);
                },
                child: Text('Create List'),
              ),
            ],
          ),
        );
      },
    );
  }

=======
>>>>>>> 5d7969395996f0ec0322a5bc2933da2e53486228
