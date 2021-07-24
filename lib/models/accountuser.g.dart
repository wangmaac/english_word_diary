// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountUser _$AccountUserFromJson(Map<String, dynamic> json) {
  return AccountUser(
    uid: json['uid'] as String,
    account: json['account'] as String,
    accountURL: json['accountURL'] as String,
    displayName: json['displayName'] as String,
  );
}

Map<String, dynamic> _$AccountUserToJson(AccountUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'account': instance.account,
      'accountURL': instance.accountURL,
      'displayName': instance.displayName,
    };
