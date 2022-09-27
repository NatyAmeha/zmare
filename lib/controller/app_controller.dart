import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/home_usecase.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';

class AppController extends GetxController {
  var _isDataLoading = true.obs;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  get isDataLoading => _isDataLoading.value;

  var _homeResult = HomeViewmodel().obs;
  HomeViewmodel get homeResult => _homeResult.value;

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
}