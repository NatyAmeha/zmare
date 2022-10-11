import 'package:json_annotation/json_annotation.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/song.dart';
part 'artist_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistViewmodel {
  String? artistId;
  Artist? artist;
  List<Song>? topSongs;
  int? totalSongs;
  int? monthlyStream;
  int? monthlyDownload;
  int? totalStream;
  int? totalDownload;
  int? rank;

  ArtistViewmodel({
    this.artistId,
    this.artist,
    this.topSongs,
    this.totalSongs,
    this.monthlyDownload,
    this.monthlyStream,
    this.totalDownload,
    this.rank,
    this.totalStream,
  });

  factory ArtistViewmodel.fromJson(Map<String, dynamic> json) =>
      _$ArtistViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistViewmodelToJson(this);
}
