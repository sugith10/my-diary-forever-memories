import 'package:diary/screens/widgets/bottomborder.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Ionicons.chevron_back_outline, color: Colors.black, size: 30),
      ),
      elevation: 0,
   
<<<<<<< HEAD
      bottom: const BottomBorderWidget()
=======
      bottom:  const BottomBorderWidget()
>>>>>>> 5d7969395996f0ec0322a5bc2933da2e53486228
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
