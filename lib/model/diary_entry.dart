import 'package:hive_flutter/hive_flutter.dart';

part 'diary_entry.g.dart';


@HiveType(typeId: 0)
class DiaryEntry { 
  @HiveField(0)               
  String id;

  @HiveField(1)
  DateTime date;                                              

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  String? imagePath;

   @HiveField(5)
  String? imagePathTwo;

  @HiveField(6)
  String? imagePathThree; 

  @HiveField(7)
  String? imagePathFour; 

  @HiveField(8)
  String? imagePathFive; 

  @HiveField(9) 
  String background;

  DiaryEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    this.imagePath, 
    this.imagePathTwo, 
    this.imagePathThree, 
    this.imagePathFour, 
    this.imagePathFive, 
    required this.background,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'content': content,
      'imagePath': imagePath,
      'imagePathTwo': imagePathTwo,
      'imagePathThree': imagePathThree,
      'imagePathFour': imagePathFour,
      'imagePathFive': imagePathFive,
      'background': background,
    };
  }
}

