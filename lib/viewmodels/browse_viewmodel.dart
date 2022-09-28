import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';

part 'browse_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseViewmodel {
  List<Playlist>? songPlaylists;
  // radioStations? : IRadio[]
  List<Artist>? artist;
  List<Playlist>? playlist;
  List<Album>? popularAlbum;
  List<Album>? newAlbum;

  List<BrowseCommand>? browseCommand;
  List<Song>? newSongs;
  List<Song>? topSongs;
  List<Song>? likedSongs;

  BrowseViewmodel(
      {this.songPlaylists,
      this.artist,
      this.playlist,
      this.popularAlbum,
      this.newAlbum,
      this.browseCommand,
      this.newSongs,
      this.topSongs,
      this.likedSongs});

  factory BrowseViewmodel.fromJson(Map<String, dynamic> json) =>
      _$BrowseViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseViewmodelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrowseCommand {
  String? name;
  String? category;
  String? contentType;
  String? imagePath;

  BrowseCommand({this.name, this.category, this.contentType, this.imagePath});

  factory BrowseCommand.fromJson(Map<String, dynamic> json) =>
      _$BrowseCommandFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseCommandToJson(this);
}
