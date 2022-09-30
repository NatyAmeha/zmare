import 'package:zema/modals/album.dart';
import 'package:zema/modals/library.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

extension apiResponseconverter on dynamic {
  dynamic toObject(String className) {
    print("class name is ${className.toString()}");
    switch (className) {
      case "HomeViewmodel":
        return HomeViewmodel.fromJson(this);
      case "Album":
        return Album.fromJson(this);

      case "ArtistViewmodel":
        return ArtistViewmodel.fromJson(this);

      case "Playlist":
        return Playlist.fromJson(this);

      case "SearchViewmodel":
        return SearchViewmodel.fromJson(this);

      case "BrowseViewmodel":
        return BrowseViewmodel.fromJson(this);

      case "Library":
        return Library.fromJson(this);

      case "String":
      case "bool":
        return this;
      default:
        null;
    }
  }
}
