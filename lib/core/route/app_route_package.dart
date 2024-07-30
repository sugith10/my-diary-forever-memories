import 'dart:io';

import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/core/route/page_transition/no_movement.dart';
import 'package:diary/feature/diary/model/diary_model.dart';
import 'package:diary/feature/diary/view/page/image_viewer_page.dart';
import 'package:flutter/material.dart';

import '../../feature/diary/view/page/create_diary_page.dart';
import '../../feature/error/view/page/error_page.dart';
import '../../feature/navigation_menu/page/main_navigation_menu.dart';
import '../../feature/onboarding/view/page/splash_page.dart';
import '../../feature/onboarding/view/page/welcome_page.dart';
import 'route_name/route_name.dart';

part 'app_route.dart';