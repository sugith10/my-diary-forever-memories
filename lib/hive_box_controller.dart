import 'package:hive_flutter/adapters.dart';

import 'feature/auth/model/app_preference_model/app_preference_model.dart';
import 'feature/archive/model/archive_diary_model/archive_diary_model.dart';
import 'core/util/hive_box_name.dart';
import 'core/model/user_model/user_model.dart';
import 'feature/customization/model/theme_model.dart';
import 'feature/saved_list/model/savedlist_model/savedlist_model.dart';

class HiveBoxController {
  static Future<void> initHive() async {
    if (!Hive.isAdapterRegistered(ThemeModelAdapter().typeId)) {
      Hive.registerAdapter(ThemeModelAdapter());
    }

   
    if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    await Hive.openBox<UserModel>(HiveBoxName.profileBox);

    if (!Hive.isAdapterRegistered(SavedListModelAdapter().typeId)) {
      Hive.registerAdapter(SavedListModelAdapter());
    }
    await Hive.openBox<SavedListModel>(HiveBoxName.SavedListModelBox);

    if (!Hive.isAdapterRegistered(AppPreferenceModelAdapter().typeId)) {
      Hive.registerAdapter(AppPreferenceModelAdapter());
    }
    await Hive.openBox<AppPreferenceModel>(HiveBoxName.AppPreferenceModelBox);

    if (!Hive.isAdapterRegistered(ArchiveDiaryModelAdapter().typeId)) {
      Hive.registerAdapter(ArchiveDiaryModelAdapter());
    }
    await Hive.openBox<ArchiveDiaryModel>(HiveBoxName.ArchiveDiaryModelBox);
  }
}
