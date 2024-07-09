import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'diary_model.g.dart';

@HiveType(typeId: 7)
class DiaryModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(9)
  Color background;

  @HiveField(4)
  String? imagePath;

  DiaryModel({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.background,
    this.imagePath,
  });

  DiaryModel copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? content,
    Color? background,
    String? imagePath,
  }) {
    return DiaryModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
      background: background ?? this.background,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'content': content,
      'background': background,
      'imagePath': imagePath,
    };
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      title: map['title'] as String,
      content: map['content'] as String,
      background: map['background'] as Color,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryModel.fromJson(String source) => DiaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiaryModel(id: $id, date: $date, title: $title, content: $content, background: $background, imagePath: $imagePath)';
  }

  @override
  bool operator ==(covariant DiaryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.date == date &&
      other.title == title &&
      other.content == content &&
      other.background == background &&
      other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date.hashCode ^
      title.hashCode ^
      content.hashCode ^
      background.hashCode ^
      imagePath.hashCode;
  }
}
