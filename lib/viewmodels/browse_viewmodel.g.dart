// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowseViewmodel _$BrowseViewmodelFromJson(Map<String, dynamic> json) =>
    BrowseViewmodel(
      songPlaylists: (json['songPlaylists'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      artist: (json['artist'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlist: (json['playlist'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularAlbum: (json['popularAlbum'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      newAlbum: (json['newAlbum'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      browseCommand: (json['browseCommand'] as List<dynamic>?)
          ?.map((e) => BrowseCommand.fromJson(e as Map<String, dynamic>))
          .toList(),
      newSongs: (json['newSongs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      topSongs: (json['topSongs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedSongs: (json['likedSongs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrowseViewmodelToJson(BrowseViewmodel instance) =>
    <String, dynamic>{
      'songPlaylists': instance.songPlaylists?.map((e) => e.toJson()).toList(),
      'artist': instance.artist?.map((e) => e.toJson()).toList(),
      'playlist': instance.playlist?.map((e) => e.toJson()).toList(),
      'popularAlbum': instance.popularAlbum?.map((e) => e.toJson()).toList(),
      'newAlbum': instance.newAlbum?.map((e) => e.toJson()).toList(),
      'browseCommand': instance.browseCommand?.map((e) => e.toJson()).toList(),
      'newSongs': instance.newSongs?.map((e) => e.toJson()).toList(),
      'topSongs': instance.topSongs?.map((e) => e.toJson()).toList(),
      'likedSongs': instance.likedSongs?.map((e) => e.toJson()).toList(),
    };

BrowseCommand _$BrowseCommandFromJson(Map<String, dynamic> json) =>
    BrowseCommand(
      name: json['name'] as String?,
      subtitle: json['subtitle'] as String?,
      category: json['category'] as String?,
      contentType: json['contentType'] as String?,
      imagePath: json['imagePath'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$BrowseCommandToJson(BrowseCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subtitle': instance.subtitle,
      'category': instance.category,
      'contentType': instance.contentType,
      'tags': instance.tags,
      'imagePath': instance.imagePath,
    };
