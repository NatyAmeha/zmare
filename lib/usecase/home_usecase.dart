import 'package:zema/repo/repository.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

class HomeUsecase {
  IRepositroy? repo;
  HomeUsecase({
    this.repo,
  });
  Future<HomeViewmodel?> getHomeData() async {
    var result = await repo?.get("/homenew") as HomeViewmodel?;

    return result;
  }

  Future<BrowseViewmodel> getBrowseResult(String category) async {
    var result = await repo?.get("/browse/$category") as BrowseViewmodel;
    return result;
  }

  Future<SearchViewmodel> getSearchResult(String query) async {
    var result = await repo?.get("/search", queryParameters: {"query": query})
        as SearchViewmodel;
    return result;
  }
}
