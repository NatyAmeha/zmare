import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/preview.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/viewmodels/fb_auth.dart';
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

      case "FBAuth":
        return FBAuth.fromJson(this);

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

extension getSongId on List<dynamic> {
  List<String> toSongId() {
    return map((e) {
      print("song data ${e.toString()}  ${e.runtimeType}");
      if (e.runtimeType.toString() == "String") {
        return e as String;
      } else {
        var mapResult = e as Map<String, dynamic>;
        var songInfo = Song.fromJson(mapResult);
        return songInfo.id!;
      }
    }).toList();
  }
}

extension PreviewToSongConverter on Preview {
  Song toSong() {
    return Song(
        id: id,
        title: title,
        songFilePath: audioFile,
        thumbnailPath: images?.first);
  }
}

extension SongToDownloadConverter on Song {
  Download toDowwnload(
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

extension SongToAudioSource on Song {
  AudioSource toAudioSource() {
    return AudioSource.uri(
      Uri.parse(songFilePath!),
      tag: MediaItem(
        id: id!,
        title: title!,
        album: albumName,
        extras: {
          "songFile": songFilePath,
          "artistNames": artistsName?.join(",")
        },
        artUri: thumbnailPath != null ? Uri.parse(thumbnailPath!) : null,
        artist: artists?.join(","),
      ),
    );
  }
}
