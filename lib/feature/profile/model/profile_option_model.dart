import 'package:flutter/material.dart';

class ProfileOptionModel {
  final IconData? icon;
  final String? svg;
  final String title;
  final VoidCallback callback;

  ProfileOptionModel({
    required this.icon,
    required this.svg,
    required this.title,
    required this.callback,
  });
}
