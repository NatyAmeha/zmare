// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistViewmodel _$ArtistViewmodelFromJson(Map<String, dynamic> json) =>
    ArtistViewmodel(
      artistId: json['artistId'] as String?,
      artist: json['artist'] == null
          ? null
          : Artist.fromJson(json['artist'] as Map<String, dynamic>),
      topSongs: (json['topSongs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSongs: json['totalSongs'] as int?,
      monthlyDownload: json['monthlyDownload'] as int?,
      monthlyStream: json['monthlyStream'] as int?,
      totalDownload: json['totalDownload'] as int?,
      rank: json['rank'] as int?,
      totalStream: json['totalStream'] as int?,
    );

Map<String, dynamic> _$ArtistViewmodelToJson(ArtistViewmodel instance) =>
    <String, dynamic>{
      'artistId': instance.artistId,
      'artist': instance.artist?.toJson(),
      'topSongs': instance.topSongs?.map((e) => e.toJson()).toList(),
      'totalSongs': instance.totalSongs,
      'monthlyStream': instance.monthlyStream,
      'monthlyDownload': instance.monthlyDownload,
      'totalStream': instance.totalStream,
      'totalDownload': instance.totalDownload,
      'rank': instance.rank,
    };
