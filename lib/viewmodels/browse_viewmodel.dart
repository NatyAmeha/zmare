import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/playlist.dart';

part 'browse_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseViewmodel {
  List<Playlist>? songPlaylists;
  // radioStations? : IRadio[]
  List<Artist>? artist;
  List<Playlist>? playlist;
  List<Album>? popularAlbum;
  List<Album>? newAlbum;

  BrowseViewmodel({
    this.songPlaylists,
    this.artist,
    this.playlist,
    this.popularAlbum,
    this.newAlbum,
  });

  factory BrowseViewmodel.fromJson(Map<String, dynamic> json) =>
      _$BrowseViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseViewmodelToJson(this);
}
