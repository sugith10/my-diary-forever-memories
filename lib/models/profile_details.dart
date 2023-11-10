import 'package:hive/hive.dart';

part 'profile_details.g.dart';

@HiveType(typeId: 1)
class ProfileDetails {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? location;

  @HiveField(4)
  String? profilePicturePath;

  ProfileDetails({
    this.id,
    required this.name,
    required this.email,
    this.location,
    this.profilePicturePath,
  });
}
