import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/local_audio_repo.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/service/permission_service.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/viewmodels/home_viewmodel.dart';
import 'package:zmare/viewmodels/search_viewmodel.dart';

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

  Future<BrowseViewmodel?> browseByTags(List<String> tags) async {
    var result = await repo?.get<BrowseViewmodel>("/browsebytags",
        queryParameters: {"tags": tags});
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
