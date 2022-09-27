import 'package:json_annotation/json_annotation.dart';
part 'song.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
class Song {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "tittle")
  String? title;
  String? genre;
  String? category;
  List<String>? tags;
  int? trackNumber;
  String? trackLength;
  DateTime? dateCreated;
  List<String>? songCredit;
  // String licenseKey;
  List<String>? language;

  int? type;
  bool? exclusive;

  String? thumbnailPath;
  // String mpdPath;
  String? songFilePath;
  String? lyrics;

  dynamic? album;
  String? albumName;

  List<String>? artists;
  List<String>? artistsName;

  int? totalStreamCount;
  int? totalDownloadCount;

  int? monthlyStreamCount;
  int? monthlyDownloadCount;

  int? todayStreamCount;
  int? todayDownloadCount;

  int? previousMonthStreamCount;
  int? previousMonthDownloadCount;

  int? likeCount;
  bool? isActive;

  Song(
      {this.id,
      this.title,
      this.category,
      this.genre,
      this.tags,
      this.album,
      this.albumName,
      this.trackNumber,
      this.trackLength,
      this.dateCreated,
      this.songCredit,
      this.language,
      this.type,
      this.exclusive,
      this.thumbnailPath,
      this.songFilePath,
      this.lyrics,
      this.artists,
      this.artistsName,
      this.totalStreamCount,
      this.totalDownloadCount,
      this.monthlyDownloadCount,
      this.monthlyStreamCount,
      this.todayStreamCount,
      this.todayDownloadCount,
      this.previousMonthDownloadCount,
      this.previousMonthStreamCount,
      this.likeCount,
      this.isActive});

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}
