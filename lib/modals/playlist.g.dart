// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      creatorId: json['creatorId'] as String?,
      creatorName: json['creatorName'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      songs: json['songs'] as List<dynamic>?,
      featured: json['featured'] as bool?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      language: json['language'] as String?,
      filter: json['filter'] as String?,
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList(),
      songsId: json['songsId'] as String?,
      isPublic: json['isPublic'] as bool?,
      followersId: (json['followersId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sid: json['sid'] as String?,
      forceUpdate: json['forceUpdate'] as bool?,
      coverImagePath: (json['coverImagePath'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'creatorId': instance.creatorId,
      'creatorName': instance.creatorName,
      'date': instance.date?.toIso8601String(),
      'songs': instance.songs,
      'featured': instance.featured,
      'type': instance.type,
      'category': instance.category,
      'language': instance.language,
      'filter': instance.filter,
      'genre': instance.genre,
      'songsId': instance.songsId,
      'isPublic': instance.isPublic,
      'followersId': instance.followersId,
      'sid': instance.sid,
      'forceUpdate': instance.forceUpdate,
      'coverImagePath': instance.coverImagePath,
    };
