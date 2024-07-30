import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show({
    required BuildContext context,
    required String title,
    required ToastificationType type,
    String? description,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: description != null ? Text(description) : null,
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 4),
      applyBlurEffect: true,
    );
  }
}
