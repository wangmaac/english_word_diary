import 'package:cloud_firestore/cloud_firestore.dart';

class MyWord {
  String title;
  String? type;
  String? meaning;
  String? example;

  MyWord({required this.title, this.type, this.meaning, this.example});

  factory MyWord.fromJson(Map<String, dynamic> json) {
    return MyWord(
        title: json['title'],
        type: json['type'],
        meaning: json['content'],
        example: json['example']);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MyWord &&
            runtimeType == other.runtimeType &&
            meaning == other.meaning &&
            example == other.example &&
            title == other.title;
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'content': this.meaning,
        'type': this.type,
        'example': this.example,
        'dttm': '',
      };

  @override
  int get hashCode {
    return meaning.hashCode ^ title.hashCode;
  }
}
