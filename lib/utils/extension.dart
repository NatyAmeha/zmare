import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/viewmodels/home_viewmodel.dart';
import 'package:zmare/viewmodels/search_viewmodel.dart';

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
  Download toDownload(
      String taskId, DownloadType type, String typeId, String typeName) {
    return Download(
      taskId: taskId,
      fileId: id,
      name: title,
      url: songFilePath,
      status: DownloadStatus.NOT_STARTED,
      type: type,
      typeId: typeId,
      typeName: typeName,
      artistNames: artistsName?.join(","),
      image: thumbnailPath,
    );
  }
}

extension DownloadToSong on Download {
  Song toSongInfo() {
    return Song(
      id: fileId.toString(),
      title: name,
      album: "album",
      artistsName: ["artist names"],
      songFilePath: location,
      thumbnailPath: image,
    );
  }
}
