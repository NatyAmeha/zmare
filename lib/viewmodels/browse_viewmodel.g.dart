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
    );

Map<String, dynamic> _$BrowseViewmodelToJson(BrowseViewmodel instance) =>
    <String, dynamic>{
      'songPlaylists': instance.songPlaylists?.map((e) => e.toJson()).toList(),
      'artist': instance.artist?.map((e) => e.toJson()).toList(),
      'playlist': instance.playlist?.map((e) => e.toJson()).toList(),
      'popularAlbum': instance.popularAlbum?.map((e) => e.toJson()).toList(),
      'newAlbum': instance.newAlbum?.map((e) => e.toJson()).toList(),
    };
