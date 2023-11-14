import 'package:hive/hive.dart';

part 'profile_details.g.dart';

@HiveType(typeId: 1)
class ProfileDetails {

  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? location;

  @HiveField(4)
  final String? profilePicturePath;

  ProfileDetails({
    this.id,
    required this.name,
    required this.email,
    this.location,
    this.profilePicturePath, 
  });
  
}
