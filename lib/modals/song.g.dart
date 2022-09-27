// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['_id'] as String?,
      title: json['tittle'] as String?,
      category: json['category'] as String?,
      genre: json['genre'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      album: json['album'],
      albumName: json['albumName'] as String?,
      trackNumber: json['trackNumber'] as int?,
      trackLength: json['trackLength'] as String?,
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
      songCredit: (json['songCredit'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as int?,
      exclusive: json['exclusive'] as bool?,
      thumbnailPath: json['thumbnailPath'] as String?,
      songFilePath: json['songFilePath'] as String?,
      lyrics: json['lyrics'] as String?,
      artists:
          (json['artists'] as List<dynamic>?)?.map((e) => e as String).toList(),
      artistsName: (json['artistsName'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      totalStreamCount: json['totalStreamCount'] as int?,
      totalDownloadCount: json['totalDownloadCount'] as int?,
      monthlyDownloadCount: json['monthlyDownloadCount'] as int?,
      monthlyStreamCount: json['monthlyStreamCount'] as int?,
      todayStreamCount: json['todayStreamCount'] as int?,
      todayDownloadCount: json['todayDownloadCount'] as int?,
      previousMonthDownloadCount: json['previousMonthDownloadCount'] as int?,
      previousMonthStreamCount: json['previousMonthStreamCount'] as int?,
      likeCount: json['likeCount'] as int?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      '_id': instance.id,
      'tittle': instance.title,
      'genre': instance.genre,
      'category': instance.category,
      'tags': instance.tags,
      'trackNumber': instance.trackNumber,
      'trackLength': instance.trackLength,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'songCredit': instance.songCredit,
      'language': instance.language,
      'type': instance.type,
      'exclusive': instance.exclusive,
      'thumbnailPath': instance.thumbnailPath,
      'songFilePath': instance.songFilePath,
      'lyrics': instance.lyrics,
      'album': instance.album,
      'albumName': instance.albumName,
      'artists': instance.artists,
      'artistsName': instance.artistsName,
      'totalStreamCount': instance.totalStreamCount,
      'totalDownloadCount': instance.totalDownloadCount,
      'monthlyStreamCount': instance.monthlyStreamCount,
      'monthlyDownloadCount': instance.monthlyDownloadCount,
      'todayStreamCount': instance.todayStreamCount,
      'todayDownloadCount': instance.todayDownloadCount,
      'previousMonthStreamCount': instance.previousMonthStreamCount,
      'previousMonthDownloadCount': instance.previousMonthDownloadCount,
      'likeCount': instance.likeCount,
      'isActive': instance.isActive,
    };
