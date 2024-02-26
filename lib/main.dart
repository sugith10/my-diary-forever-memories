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
  await Hive.openBox<DiaryEntry>('diaryEntryBox');

  if (!Hive.isAdapterRegistered(ProfileDetailsAdapter().typeId)) {
    Hive.registerAdapter(ProfileDetailsAdapter());
  }
  await Hive.openBox<ProfileDetails>('profileBox');

  if (!Hive.isAdapterRegistered(SavedListAdapter().typeId)) {
    Hive.registerAdapter(SavedListAdapter());
  }
  await Hive.openBox<SavedList>('savedListBoxName');

  if (!Hive.isAdapterRegistered(AppPreferenceAdapter().typeId)) {
    Hive.registerAdapter(AppPreferenceAdapter());
  }
  await Hive.openBox<AppPreference>('appPreferenceBox');

  if (!Hive.isAdapterRegistered(ArchiveDiaryAdapter().typeId)) {
    Hive.registerAdapter(ArchiveDiaryAdapter());
  }
  await Hive.openBox<ArchiveDiary>('archiveDiaryBox');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}
