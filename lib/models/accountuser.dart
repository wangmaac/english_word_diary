import 'package:json_annotation/json_annotation.dart';

part 'accountuser.g.dart';

@JsonSerializable()
class AccountUser {
  final String uid;
  final String account;
  final String accountURL;
  final String displayName;

  AccountUser(
      {required this.uid,
      required this.account,
      required this.accountURL,
      required this.displayName});
  factory AccountUser.fromJson(Map<String, dynamic> json) => _$AccountUserFromJson(json);
  Map<String, dynamic> toJson() => _$AccountUserToJson(this);
}
