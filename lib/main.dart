import 'package:diary/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/model/hive/hive_box_name.dart';
import 'data/model/hive/app_preference_db_model/app_preference_db_model.dart';
import 'data/model/hive/archive_db_model/archive_db_model.dart';
import 'data/model/hive/diary_entry_db_model/diary_entry.dart';
import 'data/model/hive/profile_details/profile_details.dart';
import 'data/model/hive/savedlist_db_model/savedlist_db_model.dart';
import 'feature/customization/model/theme_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    Hive.initFlutter()
  ]);

  if (!Hive.isAdapterRegistered(ThemeModelAdapter().typeId)) {
    Hive.registerAdapter(ThemeModelAdapter());
  }

  if (!Hive.isAdapterRegistered(DiaryEntryAdapter().typeId)) {
    Hive.registerAdapter(DiaryEntryAdapter());
  }
  await Hive.openBox<DiaryEntry>(HiveBoxName.diaryBox);

  if (!Hive.isAdapterRegistered(ProfileDetailsAdapter().typeId)) {
    Hive.registerAdapter(ProfileDetailsAdapter());
  }
  await Hive.openBox<ProfileDetails>(HiveBoxName.profileBox);

  if (!Hive.isAdapterRegistered(SavedListAdapter().typeId)) {
    Hive.registerAdapter(SavedListAdapter());
  }
  await Hive.openBox<SavedList>(HiveBoxName.savedListBox);

  if (!Hive.isAdapterRegistered(AppPreferenceAdapter().typeId)) {
    Hive.registerAdapter(AppPreferenceAdapter());
  }
  await Hive.openBox<AppPreference>(HiveBoxName.appPreferenceBox);

  if (!Hive.isAdapterRegistered(ArchiveDiaryAdapter().typeId)) {
    Hive.registerAdapter(ArchiveDiaryAdapter());
  }
  await Hive.openBox<ArchiveDiary>(HiveBoxName.archiveDiaryBox);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}
