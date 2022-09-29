import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/home_usecase.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

import '../repo/shared_pref_repo.dart';

class AppController extends GetxController {
  var _isDataLoading = true.obs;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  removeException() {
    _exception(AppException());
  }

  get isDataLoading => _isDataLoading.value;

  var loggedInUser = User().obs;
  User get loggedInUserResult => loggedInUser.value;

  var _homeResult = HomeViewmodel().obs;
  HomeViewmodel get homeResult => _homeResult.value;

  var _browseResult = BrowseViewmodel().obs;
  BrowseViewmodel get browseResult => _browseResult.value;

  var _searchResult = SearchViewmodel().obs;
  SearchViewmodel get searhResult => _searchResult.value;

  @override
  onInit() {
    getHomeData();
    super.onInit();
  }

  getHomeData() async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<HomeViewmodel>());
      var result = await usecase.getHomeData();
      _isDataLoading(false);
      _homeResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getBrowseResult(String category) async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<BrowseViewmodel>());
      var result = await usecase.getBrowseResult(category);
      _isDataLoading(false);
      print(result.topSongs?.length);
      _browseResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getSearchResult(String query) async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<SearchViewmodel>());
      var result = await usecase.getSearchResult(query);
      _isDataLoading(false);
      _searchResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  Future<String?> getUserId() async {
    var userUsecase =
        UserUsecase(sharedPrefRepo: const SharedPreferenceRepository<String>());
    var userIdResult = await userUsecase.getUserIdFromPref();
    return userIdResult;
  }
}
