import 'package:zema/repo/repository.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';

class HomeUsecase {
  IRepositroy? repo;
  HomeUsecase({
    this.repo,
  });
  Future<HomeViewmodel?> getHomeData() async {
    var result = await repo?.get("/homenew") as HomeViewmodel?;
    print("featured playlist");
    print(result?.popularArtist?.elementAt(0).profileImagePath);
    return result;
  }
}
