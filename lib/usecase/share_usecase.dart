import 'package:zmare/service/share_service.dart';

class ShareUsecase {
  IShareService shareService;

  ShareUsecase({this.shareService = const ShareService()});

  Future<void> share(String title, String message) async {
    var result = await shareService.share(title, message);
  }
}
