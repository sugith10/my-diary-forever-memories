import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {

  @HiveField(0)
  final String id = "1";

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? location;

  @HiveField(4)
  final String? profilePicturePath;

  UserModel({
    required this.name,
    required this.email,
    this.location,
    this.profilePicturePath, 
  });
  
}
