import 'package:json_annotation/json_annotation.dart';
part 'artist.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.none)
class Artist {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? description;
  String? email;
  DateTime? dateCreated;
  @JsonKey(name: "new")
  bool? isNew;
  String? category;
  List<String>? genre;
  List<String>? profileImagePath;

  List<dynamic>? albums;
  List<String>? albumsId;

  List<dynamic>? singleSongs;
  List<String>? singleSongsId;

  List<String>? followersId;
  int? followersCount;

  int? totalStreamCount;
  int? monthlyStreamCount;

  int? totalDownloadCount;
  int? monthlyDownloadCount;

  // String paymentMethod;
  bool? donationEnabled;
  bool? isActive;
  // user? : IUser | String

  Artist({
    this.id,
    this.name,
    this.description,
    this.email,
    this.dateCreated,
    this.isNew,
    this.category,
    this.genre,
    this.profileImagePath,
    this.albums,
    this.albumsId,
    this.singleSongs,
    this.singleSongsId,
    this.followersId,
    this.followersCount,
    this.totalStreamCount,
    this.monthlyStreamCount,
    this.totalDownloadCount,
    this.monthlyDownloadCount,
    this.donationEnabled,
    this.isActive,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
