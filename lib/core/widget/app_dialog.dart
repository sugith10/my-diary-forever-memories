import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color/app_colors.dart';

class AppDialog {
  static show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String action,
    required VoidCallback actionCall,
    Color? actionColor,
    Widget? actionWidget,
    bool actionPop = false,
    String canecel = "Cancel",
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 25.h),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 10.h),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                _MessageButton(
                  action: canecel,
                  backgroundColor: AppDarkColor.instance.primaryText,
                  foregroundColor: AppDarkColor.instance.background,
                  callback: () => Navigator.pop(context),
                ),
                SizedBox(height: 12.h),
                _MessageButton(
                  action: action,
                  backgroundColor: actionColor ?? AppDarkColor.instance.danger,
                  foregroundColor: AppDarkColor.instance.primaryText,
                  callback: () {
                    if (actionPop) {
                      Navigator.pop(context);
                    }
                    actionCall();
                  },
                  actionWidget: actionWidget,
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MessageButton extends StatelessWidget {
  final String action;
  final VoidCallback callback;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? actionWidget;
  const _MessageButton({
    required this.action,
    required this.backgroundColor,
    required this.callback,
    required this.foregroundColor,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              callback();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              foregroundColor: WidgetStatePropertyAll(foregroundColor),
            ),
            child: actionWidget ?? Text(action),
          ),
        ),
      ],
    );
  }
}
