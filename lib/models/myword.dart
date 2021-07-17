import 'package:cloud_firestore/cloud_firestore.dart';

class MyWord {
  String title;
  String? type;
  String? meaning;
  String? example;

  MyWord(this.title, this.type, this.meaning, this.example);

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
