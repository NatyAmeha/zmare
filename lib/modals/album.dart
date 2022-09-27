import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/song.dart';
part 'album.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
class Album {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? genre;
  String? category;
  List<String>? tags;
  List<String>? language;
  DateTime? dateCreated;
  @JsonKey(name: "albumCoverPath")
  String? artWork;
  int? favoriteCount;
  bool? exclusive;
  @JsonKey(name: "songs")
  List<dynamic>? songs;
  List<String>? songsId;
  @JsonKey(name: "artists")
  List<dynamic>? artists;
  List<String>? artistsName;
  bool? isActive;
  bool? makeAlbumActive;
  Album({
    this.id,
    this.name,
    this.genre,
    this.category,
    this.tags,
    this.language,
    this.dateCreated,
    this.artWork,
    this.favoriteCount,
    this.exclusive,
    this.songs,
    this.songsId,
    this.artists,
    this.artistsName,
    this.isActive,
    this.makeAlbumActive,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
