import 'dart:developer';
import 'package:diary/models/profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


final ValueNotifier<List<ProfileDetails>> profileDetailsNotifier =
    ValueNotifier<List<ProfileDetails>>([]);

class ProfileFunctions {
  List<ProfileDetails> profileDetailsNotifier = [];
  final box = Hive.box<ProfileDetails>('_profileBoxName');

  Future addProfileDetails(ProfileDetails details) async {
    final box = Hive.box<ProfileDetails>('_profileBoxName');
    await box.put(details.id, details);

    profileDetailsNotifier.add(details);

    // profileDetailsNotifier.notifyListeners();
  }

  Future getAllProfileDetails() async {
    final box = Hive.box<ProfileDetails>('_profileBoxName');
    profileDetailsNotifier.clear();
    profileDetailsNotifier.addAll(box.values);
    // profileDetailsNotifier.notifyListeners();
  }

  Future<void> deleteProfileDetails(String id) async {
    final box = Hive.box<ProfileDetails>('_profileBoxName');
    if (box.containsKey(id)) {
      box.delete(id);
      log('Deleted profile details with ID: $id');
    } else {
      log('Profile details with ID $id not found');
    }
  }

  Future<void> updateProfileDetails(ProfileDetails details) async {
    final box = Hive.box<ProfileDetails>('_profileBoxName');
    if (box.containsKey(details.id)) {
      await box.put(details.id, details);
      log('Updated profile details with ID: ${details.id}');
    } else {
      log('Profile details with ID ${details.id} not found, cannot update.');
    }
  }
}
