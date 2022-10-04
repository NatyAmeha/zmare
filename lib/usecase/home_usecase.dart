import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/local_audio_repo.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/service/permission_service.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

class HomeUsecase {
  IRepositroy? repo;
  IPremissionService? permissionService;
  HomeUsecase({
    this.repo,
    this.permissionService,
  });
  Future<HomeViewmodel> getHomeData() async {
    var result = await repo?.get<HomeViewmodel>("/homenew") as HomeViewmodel;
    print(result?.recentActivity?.length);
    return result;
  }

  Future<BrowseViewmodel?> getBrowseResult(String category) async {
    var result = await repo?.get<BrowseViewmodel>("/browse/$category");
    return result;
  }

  Future<SearchViewmodel> getSearchResult(String query) async {
    var result = await repo?.get<SearchViewmodel>("/search",
        queryParameters: {"query": query}) as SearchViewmodel;
    return result;
  }

  Future<HomeViewmodel> getLocalAudioFiles() async {
    var permissionStatus = await permissionService!.requestStoragePermission();
    print("permission status ${permissionStatus.toString()}");
    if (permissionStatus) {
      var songs = await repo!.getAll<Song>("");
      var albums = await repo!.getAll<Album>("");
      var playlists = await repo!.getAll<Playlist>("");
      var artists = await repo!.getAll<Artist>("");
      var result = HomeViewmodel(
        songs: songs,
        albums: albums,
        artists: artists,
        playlists: playlists,
      );
      return result;
    } else {
      return Future.error(AppException(message: "Storage permission denied"));
    }
  }

  Future<List<Song>> getSongsFrom(String id, AudiosFromType type) async {
    var localRepo = (repo as ILocalAudioRepo);
    var result = await localRepo.querySongsFrom(id, type);
    return result;
  }
}
