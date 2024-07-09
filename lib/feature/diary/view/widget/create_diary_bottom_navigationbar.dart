import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widget/svg_icon.dart';
import '../../../../core/util/asset_path/app_svg.dart';

class CreateDiaryBottomBar extends StatelessWidget {

  final Function(int) function;

  const CreateDiaryBottomBar({
    super.key,

    required this.function,
  });

  @override
  Widget build(BuildContext context) {
   return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomNavigationBar(
            enableFeedback: true,
         
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            
            onTap: function,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.clock,
                ),
                label: 'Time',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.images,
                ),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(path: AppSvg.colorPick),
                label: 'Color',
              ),
            ],
          ),
        );
  }
}
