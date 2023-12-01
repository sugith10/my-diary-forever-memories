import 'dart:developer';
import 'package:diary/domain/models/profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

final ValueNotifier<List<ProfileDetails>> profileDetailsNotifier =
    ValueNotifier<List<ProfileDetails>>([]);

class ProfileFunctions {
  List<ProfileDetails> profileDetailsNotifier = [];
  final box = Hive.box<ProfileDetails>('_profileBoxName');

  Future<void> addProfileDetails(ProfileDetails details) async {
    await box.put(details.id, details);
    log('Added profile details successfully');
  }
  
  List<ProfileDetails> getAllProfileDetails() {
    return box.values.toList();
  }
}
