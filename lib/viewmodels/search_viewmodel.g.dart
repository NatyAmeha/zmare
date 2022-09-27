// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchViewmodel _$SearchViewmodelFromJson(Map<String, dynamic> json) =>
    SearchViewmodel(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchViewmodelToJson(SearchViewmodel instance) =>
    <String, dynamic>{
      'songs': instance.songs?.map((e) => e.toJson()).toList(),
      'albums': instance.albums?.map((e) => e.toJson()).toList(),
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'playlists': instance.playlists?.map((e) => e.toJson()).toList(),
    };
