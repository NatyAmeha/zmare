import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/modals/library.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
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

      case "Artist":
        return Artist.fromJson(this);

      case "Song":
        return Song.fromJson(this);

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

extension SongToDownloadConverter on Song {
  Download toDownload(String taskId, DownloadType type, String typeId) {
    return Download(
      taskId: taskId,
      fileId: id,
      name: title,
      url: songFilePath,
      status: DownloadStatus.NOT_STARTED,
      type: type,
      typeId: typeId,
      image: thumbnailPath,
    );
  }
}
