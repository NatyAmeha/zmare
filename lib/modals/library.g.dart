// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) => Library(
      likedSong: (json['likedSong'] as List<dynamic>?)
          ?.map((e) => LibraryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedAlbums: (json['likedAlbums'] as List<dynamic>?)
          ?.map((e) => LibraryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedPlaylist: (json['likedPlaylist'] as List<dynamic>?)
          ?.map((e) => LibraryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..followedArtists = (json['followedArtists'] as List<dynamic>?)
        ?.map((e) => LibraryItem.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'likedSong': instance.likedSong?.map((e) => e.toJson()).toList(),
      'likedAlbums': instance.likedAlbums?.map((e) => e.toJson()).toList(),
      'likedPlaylist': instance.likedPlaylist?.map((e) => e.toJson()).toList(),
      'followedArtists':
          instance.followedArtists?.map((e) => e.toJson()).toList(),
    };

LibraryItem _$LibraryItemFromJson(Map<String, dynamic> json) => LibraryItem(
      id: json['songId'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$LibraryItemToJson(LibraryItem instance) =>
    <String, dynamic>{
      'songId': instance.id,
      'date': instance.date?.toIso8601String(),
    };
