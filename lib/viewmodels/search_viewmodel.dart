import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';
part 'search_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchViewmodel {
  List<Song>? songs;
  List<Album>? albums;
  List<Artist>? artists;
  List<Playlist>? playlists;
  // List<Song>?  audiobooks;
  // List<Song>?  books;
  // List<Song>  authors?: IAuthorModel[],
  // List<Song>  podcasts?: IPodcastModel[],
  // List<Song>  episodes?: IPodcastEpisodeModel[]
  // List<Song>  products? : IProductModel[]
  // List<Song>  packages? : IPackageModel[]

  SearchViewmodel({
    this.songs,
    this.albums,
    this.artists,
    this.playlists,
  });

  factory SearchViewmodel.fromJson(Map<String, dynamic> json) =>
      _$SearchViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchViewmodelToJson(this);
}
