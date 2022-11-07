import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/repository.dart';

abstract class ILocalAudioRepo<T> extends IRepositroy<T> {
  Future<List<Song>> querySongsFrom(String id, AudiosFromType type);
}

class LocalAudioRepo extends ILocalAudioRepo {
  var audioQuery = OnAudioQuery();
  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<R?> get<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return null;
  }

  @override
  Future<List<R>> getAll<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      switch (R) {
        case Song:
          var result = await audioQuery.querySongs();
          print("songs");
          print(result);
          var songResult = result
              .map((e) => Song(
                    songFilePath: e.uri,
                    id: e.id.toString(),
                    title: e.title,
                    albumName: e.album,
                    artistsName: [e.artist ?? ""],
                    album: e.albumId,
                    artists: [e.artistId.toString()],
                  ))
              .toList();

          return songResult as List<R>;
        case Album:
          var result = await audioQuery.queryAlbums();
          print("albums");
          print(result);
          var albumResult = result
              .map((e) => Album(
                  id: e.id.toString(),
                  name: e.album,
                  artists: [e.artistId.toString()],
                  artistsName: [e.artist ?? ""],
                  songs: []))
              .toList();
          return albumResult as List<R>;

        case Artist:
          var result = await audioQuery.queryArtists();
          print("artist");
          print(result);
          var artistResult = result
              .map((e) => Artist(
                  id: e.id.toString(),
                  name: e.artist,
                  followersCount: e.numberOfAlbums))
              .toList();

          return artistResult as List<R>;

        case Playlist:
          var result = await audioQuery.queryPlaylists();
          print("playlist");
          print(result);
          var playlistResult = result
              .map((e) => Playlist(
                  id: e.id.toString(), name: e.playlist, creatorName: e.data))
              .toList();

          return playlistResult as List<R>;
        default:
          return Future.error(
              AppException(message: "Unable to query from local storage"));
      }
    } catch (ex) {
      print(ex.toString());
      return Future.error(AppException(message: ex.toString()));
    }
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<Song>> querySongsFrom(String id, AudiosFromType type) async {
    try {
      late List<SongModel> result;
      // switch (type) {
      //   case AudiosFromType.ALBUM_ID:
      //     result = await audioQuery.queryAudiosFrom(
      //       type, id, sortType: SongSortType.TITLE, // Default
      //       orderType: OrderType.ASC_OR_SMALLER,
      //     );
      //     break;
      //   case AudiosFromType.PLAYLIST:
      //     result = await audioQuery.queryAudiosFrom(
      //       type, id, sortType: SongSortType.TITLE, // Default
      //       orderType: OrderType.ASC_OR_SMALLER,
      //     );
      //     break;
      //   case AudiosFromType.ARTIST_ID:
      //     result = await audioQuery.queryAudiosFrom(
      //       type, id, sortType: SongSortType.TITLE, // Default
      //       orderType: OrderType.ASC_OR_SMALLER,
      //     );
      //     break;

      //   default:
      //     result = await audioQuery.querySongs();
      // }
      result = await audioQuery.queryAudiosFrom(
        type, id, sortType: SongSortType.TITLE, // Default
        orderType: OrderType.ASC_OR_SMALLER,
      );

      var songResult = result
          .map((e) => Song(
                songFilePath: e.uri,
                id: e.id.toString(),
                title: e.title,
                albumName: e.album,
                artistsName: [e.artist ?? ""],
                album: e.albumId,
                artists: [e.artistId.toString()],
              ))
          .toList();
      return songResult;
    } catch (ex) {
      return Future.error(AppException(message: 'unable to query audio files'));
    }
  }
}
