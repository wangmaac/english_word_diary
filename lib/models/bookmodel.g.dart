// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map json) {
  return BookModel(
    owner: json['owner'] as String,
    category: json['category'] as String,
    dttm: const TimestampConverter().fromJson(json['dttm'] as Timestamp),
    title: json['title'] as String,
    uid: json['uid'] as String,
    imageURL: json['imageURL'] as String,
  )..myWordList = (json['myWordList'] as List<dynamic>?)
      ?.map((e) => MyWord.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'title': instance.title,
      'uid': instance.uid,
      'owner': instance.owner,
      'imageURL': instance.imageURL,
      'category': instance.category,
      'dttm': const TimestampConverter().toJson(instance.dttm),
      'myWordList': instance.myWordList,
    };
