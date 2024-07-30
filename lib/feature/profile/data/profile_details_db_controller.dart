import 'dart:developer';
import 'package:diary/core/model/user_model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for storing UserModel profile details.
final class UserModelDatabaseManager {
  /// Notifier for changes in the list of UserModel profile details.
  final ValueNotifier<List<UserModel>> UserModelNotifier =
      ValueNotifier<List<UserModel>>([]);

  /// Hive box for storing UserModel profile details.
  final box = Hive.box<UserModel>('profileBox');

  /// Adds UserModel profile details to the database.
  Future<void> addUserModel(UserModel details) async {
    await box.put(details.id, details);
    log('Added profile details successfully');
    updateNotifier();
  }

  /// Retrieves all UserModel profile details from the database.
  List<UserModel> getAllUserModel() {
    return box.values.toList();
  }

  /// Updates the value of the profile details notifier.
  void updateNotifier() {
    UserModelNotifier.value = getAllUserModel();
  }
}
