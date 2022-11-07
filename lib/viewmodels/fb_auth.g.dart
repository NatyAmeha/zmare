// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBAuth _$FBAuthFromJson(Map<String, dynamic> json) => FBAuth(
      token: json['token'] as String?,
      isNewUser: json['isNewUser'] as bool?,
    );

Map<String, dynamic> _$FBAuthToJson(FBAuth instance) => <String, dynamic>{
      'token': instance.token,
      'isNewUser': instance.isNewUser,
    };
