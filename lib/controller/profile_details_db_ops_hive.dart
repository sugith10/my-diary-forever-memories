import 'dart:developer';
import 'package:diary/model/profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ProfileDetailsCtrl {
  final ValueNotifier<List<ProfileDetails>> profileDetailsNotifier =
      ValueNotifier<List<ProfileDetails>>([]);

  final box = Hive.box<ProfileDetails>('_profileBoxName');

  Future<void> addProfileDetails(ProfileDetails details) async {
    await box.put(details.id, details);
    log('Added profile details successfully');
    updateNotifier();
  }

  List<ProfileDetails> getAllProfileDetails() {
    return box.values.toList();
  }

  void updateNotifier() {
    profileDetailsNotifier.value = getAllProfileDetails();
  }
}
