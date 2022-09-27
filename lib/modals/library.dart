import 'package:json_annotation/json_annotation.dart';
part 'library.g.dart';

@JsonSerializable(explicitToJson: true)
class Library {
  List<LibraryItem>? likedSong;
  List<LibraryItem>? likedAlbums;
  List<LibraryItem>? likedPlaylist;
  // radioStations? : {
  //     radioId : String| IRadio
  //     likedTag? : String[]
  //     unlikedTag? : String[]
  // }[]
  List<LibraryItem>? followedArtists;

  Library({
    this.likedSong,
    this.likedAlbums,
    this.likedPlaylist,
  });

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LibraryItem {
  @JsonKey(name: "songId")
  @JsonKey(name: "albumId")
  @JsonKey(name: "playlistID")
  @JsonKey(name: "artistId")
  @JsonKey(name: "radioId")
  String? id;
  DateTime? date;

  LibraryItem({this.id, this.date});

  factory LibraryItem.fromJson(Map<String, dynamic> json) =>
      _$LibraryItemFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryItemToJson(this);
}
