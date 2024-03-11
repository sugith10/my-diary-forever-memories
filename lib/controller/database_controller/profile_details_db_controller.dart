import 'dart:developer';
import 'package:diary/features/user_details/profile_details/profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages interactions with the Hive database for storing user profile details.
final class ProfileDetailsDatabaseManager {
  /// Notifier for changes in the list of user profile details.
  final ValueNotifier<List<ProfileDetails>> profileDetailsNotifier =
      ValueNotifier<List<ProfileDetails>>([]);

  /// Hive box for storing user profile details.
  final box = Hive.box<ProfileDetails>('profileBox');

  /// Adds user profile details to the database.
  Future<void> addProfileDetails(ProfileDetails details) async {
    await box.put(details.id, details);
    log('Added profile details successfully');
    updateNotifier();
  }

  /// Retrieves all user profile details from the database.
  List<ProfileDetails> getAllProfileDetails() {
    return box.values.toList();
  }

  /// Updates the value of the profile details notifier.
  void updateNotifier() {
    profileDetailsNotifier.value = getAllProfileDetails();
  }
}
