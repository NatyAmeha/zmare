// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      genre: json['genre'] as String?,
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      artWork: json['albumCoverPath'] as String?,
      favoriteCount: json['favoriteCount'] as int?,
      exclusive: json['exclusive'] as bool?,
      songs: json['songs'] as List<dynamic>?,
      songsId:
          (json['songsId'] as List<dynamic>?)?.map((e) => e as String).toList(),
      artists: json['artists'] as List<dynamic>?,
      artistsName: (json['artistsName'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool?,
      makeAlbumActive: json['makeAlbumActive'] as bool?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'genre': instance.genre,
      'category': instance.category,
      'tags': instance.tags,
      'language': instance.language,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'albumCoverPath': instance.artWork,
      'favoriteCount': instance.favoriteCount,
      'exclusive': instance.exclusive,
      'songs': instance.songs,
      'songsId': instance.songsId,
      'artists': instance.artists,
      'artistsName': instance.artistsName,
      'isActive': instance.isActive,
      'makeAlbumActive': instance.makeAlbumActive,
    };
