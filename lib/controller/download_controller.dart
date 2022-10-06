import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/db/db_repo.dart';
import 'package:zema/usecase/download_usecase.dart';

class DownloadController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  List<Download>? downloadResult;

  getDownloads() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DBRepo());
      var result = await downloadUsecase.getDownloads();
      downloadResult = result;
    } catch (ex) {
      print("fetch data error");
      print(ex.toString());
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
