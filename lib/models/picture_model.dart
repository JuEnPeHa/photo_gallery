import 'package:hive_flutter/hive_flutter.dart';

part 'picture_model.g.dart';

@HiveType(typeId: 1)
class PictureModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String base64;
  @HiveField(4)
  final String tag;
  @HiveField(5)
  final DateTime date;

  PictureModel({
    required this.id,
    required this.title,
    required this.description,
    required this.base64,
    required this.tag,
    required this.date,
  });

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      base64: json['base64'],
      tag: json['tag'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'base64': base64,
      'tag': tag,
      'date': date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PictureModel(id: $id, title: $title, description: $description, base64: $base64, tag: $tag, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PictureModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.base64 == base64 &&
        other.tag == tag &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        base64.hashCode ^
        tag.hashCode ^
        date.hashCode;
  }

  PictureModel copyWith({
    String? id,
    String? title,
    String? description,
    String? base64,
    String? tag,
    DateTime? date,
  }) {
    return PictureModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      base64: base64 ?? this.base64,
      tag: tag ?? this.tag,
      date: date ?? this.date,
    );
  }
}
