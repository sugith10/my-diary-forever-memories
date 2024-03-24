import 'package:diary/core/hive_box_names/hive_box_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'app.dart';
import 'model/hive_database_model/app_preference_db_model/app_preference_db_model.dart';
import 'model/hive_database_model/archive_db_model/archive_db_model.dart';
import 'model/hive_database_model/diary_entry_db_model/diary_entry.dart';
import 'model/hive_database_model/profile_details/profile_details.dart';
import 'model/hive_database_model/savedlist_db_model/savedlist_db_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

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
