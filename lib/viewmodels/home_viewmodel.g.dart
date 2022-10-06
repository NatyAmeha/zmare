// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeViewmodel _$HomeViewmodelFromJson(Map<String, dynamic> json) =>
    HomeViewmodel(
      recentActivity: (json['recentActivity'] as List<dynamic>?)
          ?.map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      newMusic: (json['newMusic'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      madeForYou: (json['madeForYou'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      topCharts: (json['topCharts'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularArtist: (json['popularArtist'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      newArtist: (json['newArtist'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedAlbum: (json['recommendedAlbum'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredPlaylist: (json['featuredPlaylist'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..newAlbum = (json['newAlbum'] as List<dynamic>?)
        ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$HomeViewmodelToJson(HomeViewmodel instance) =>
    <String, dynamic>{
      'recentActivity':
          instance.recentActivity?.map((e) => e.toJson()).toList(),
      'newMusic': instance.newMusic?.map((e) => e.toJson()).toList(),
      'madeForYou': instance.madeForYou?.map((e) => e.toJson()).toList(),
      'topCharts': instance.topCharts?.map((e) => e.toJson()).toList(),
      'popularArtist': instance.popularArtist?.map((e) => e.toJson()).toList(),
      'newArtist': instance.newArtist?.map((e) => e.toJson()).toList(),
      'newAlbum': instance.newAlbum?.map((e) => e.toJson()).toList(),
      'recommendedAlbum':
          instance.recommendedAlbum?.map((e) => e.toJson()).toList(),
      'featuredPlaylist':
          instance.featuredPlaylist?.map((e) => e.toJson()).toList(),
      'songs': instance.songs?.map((e) => e.toJson()).toList(),
      'albums': instance.albums?.map((e) => e.toJson()).toList(),
      'playlists': instance.playlists?.map((e) => e.toJson()).toList(),
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
    };
