// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      profileImagePath: json['profileImagePath'] as String?,
      recent: json['recent'] == null
          ? null
          : RecentActivity.fromJson(json['recent'] as Map<String, dynamic>),
      library: json['library'] == null
          ? null
          : Library.fromJson(json['library'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profileImagePath': instance.profileImagePath,
      'category': instance.category,
      'recent': instance.recent?.toJson(),
      'library': instance.library?.toJson(),
    };

RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) =>
    RecentActivity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$RecentActivityToJson(RecentActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date?.toIso8601String(),
    };
