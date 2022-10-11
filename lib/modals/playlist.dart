import 'package:json_annotation/json_annotation.dart';
import 'package:zmare/modals/song.dart';
part 'playlist.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
class Playlist {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? creatorId;
  String? creatorName;
  DateTime? date;
  List<dynamic>? songs;
  bool? featured;
  String? type; //value = CHART or null
  String? category; // used also for chart selection
  String? language; // used also for chart selection
  String?
      filter; // used for chart selection based on today stream ,  monthly stream ,  most liked   value = Today , Month , liked
  List<String>? genre;
  String? songsId;
  bool? isPublic;
  List<String>? followersId;
  String? sid;
  bool? forceUpdate;
  List<String>? coverImagePath;

  Playlist({
    this.id,
    this.name,
    this.creatorId,
    this.creatorName,
    this.date,
    this.songs,
    this.featured,
    this.type,
    this.category,
    this.language,
    this.filter,
    this.genre,
    this.songsId,
    this.isPublic,
    this.followersId,
    this.sid,
    this.forceUpdate,
    this.coverImagePath,
  });

  factory Playlist.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
