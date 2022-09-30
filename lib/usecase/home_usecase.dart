import 'package:zema/repo/repository.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

class HomeUsecase {
  IRepositroy? repo;
  HomeUsecase({
    this.repo,
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
}
