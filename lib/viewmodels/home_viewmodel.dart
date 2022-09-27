import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/user.dart';

part 'home_viewmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeViewmodel {
  List<RecentActivity>? recentActivity;
  List<Playlist>? newMusic;
  List<Playlist>? madeForYou;
  List<Playlist>? topCharts;
  List<Artist>? popularArtist;
  List<Artist>? newArtist;
  List<Album>? newAlbum;
  List<Album>? recommendedAlbum;
  List<Playlist>? featuredPlaylist;
  // featuredRadio? : IRadio[]
  // popularRadio? : IRadio[]
  // topCreatorByDonation? : DonationViewmodel[]

  HomeViewmodel({
    this.recentActivity,
    this.newMusic,
    this.madeForYou,
    this.topCharts,
    this.popularArtist,
    this.newArtist,
    this.recommendedAlbum,
    this.featuredPlaylist,
  });

  factory HomeViewmodel.fromJson(Map<String, dynamic> json) =>
      _$HomeViewmodelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeViewmodelToJson(this);
}
