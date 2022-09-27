// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      isNew: json['new'] as bool?,
      category: json['category'] as String?,
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList(),
      profileImagePath: (json['profileImagePath'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      albums: json['albums'] as List<dynamic>?,
      albumsId: (json['albumsId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      singleSongs: json['singleSongs'] as List<dynamic>?,
      singleSongsId: (json['singleSongsId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followersId: (json['followersId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followersCount: json['followersCount'] as int?,
      totalStreamCount: json['totalStreamCount'] as int?,
      monthlyStreamCount: json['monthlyStreamCount'] as int?,
      totalDownloadCount: json['totalDownloadCount'] as int?,
      monthlyDownloadCount: json['monthlyDownloadCount'] as int?,
      donationEnabled: json['donationEnabled'] as bool?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'new': instance.isNew,
      'category': instance.category,
      'genre': instance.genre,
      'profileImagePath': instance.profileImagePath,
      'albums': instance.albums,
      'albumsId': instance.albumsId,
      'singleSongs': instance.singleSongs,
      'singleSongsId': instance.singleSongsId,
      'followersId': instance.followersId,
      'followersCount': instance.followersCount,
      'totalStreamCount': instance.totalStreamCount,
      'monthlyStreamCount': instance.monthlyStreamCount,
      'totalDownloadCount': instance.totalDownloadCount,
      'monthlyDownloadCount': instance.monthlyDownloadCount,
      'donationEnabled': instance.donationEnabled,
      'isActive': instance.isActive,
    };
