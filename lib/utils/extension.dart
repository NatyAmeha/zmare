import 'package:zema/modals/album.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';

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

      case "String":
      case "bool":
        return this;
      default:
        null;
    }
  }
}
