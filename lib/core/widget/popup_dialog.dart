import 'package:diary/core/util/util/get_colors.dart';
import 'package:flutter/material.dart';

class ShowPopUp {
  void _showPopupDialog(BuildContext context, String warning, String detail,
      String action, Function function) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GetColors().getAlertBoxColor(context),
          title: Center(
            child: Text(
              warning,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                detail,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      Text(action, style: const TextStyle(color: Colors.red)),
                  onPressed: () async {
                    function;
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  showPopupDialog(BuildContext context, String warning, String detail,
      String action, Function function) {
    _showPopupDialog(context, warning, detail, action, function);
  }
}
