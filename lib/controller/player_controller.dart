import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';

class PlayerController extends GetxController {
  var appController = Get.find<AppController>();
  var queueScrollPosition = false.obs;
}
