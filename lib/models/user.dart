import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;
  String email;
  String? userName;
  String? imageURL;
  int? level;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyUser({
    required this.uid,
    required this.email,
    this.userName,
    this.imageURL,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  MyUser.fromMap(Map<String, dynamic> map)
      : this.uid = map["uid"],
        this.email = map["email"],
        this.userName = map["userName"],
        this.imageURL = map["imageURL"],
        this.level = int.parse(map["level"]),
        this.createdAt = (map["createdAt"] as Timestamp).toDate(),
        this.updatedAt = (map["updatedAt"] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    DateTime now = DateTime.now().toLocal().toUtc();
    return {
      'uid': this.uid,
      'email': this.email,
      'userName': this.userName ??
          this.email.substring(0, this.email.indexOf("@")) + Random().nextInt(1000).toString(),
      'imageURL': this.imageURL ??
          "https://www.logolynx.com/images/logolynx/61/61ba01858af7f2ea1184238e9f2771f2.png",
      'level': this.level ?? 1,
      'createdAt': this.createdAt ?? now,
      'updatedAt': this.updatedAt ?? now,
    };
  }
}
