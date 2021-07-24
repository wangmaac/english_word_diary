import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmodel.g.dart';

@JsonSerializable(anyMap: true)
class BookModel {
  final String title;
  final String uid;
  final String owner;
  final String imageURL;
  final String category;
  @TimestampConverter()
  final DateTime dttm;

  List<MyWord>? myWordList;

  BookModel(
      {required this.owner,
      required this.category,
      required this.dttm,
      required this.title,
      required this.uid,
      required this.imageURL});

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
