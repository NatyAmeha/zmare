import 'package:share_plus/share_plus.dart';
import 'package:zmare/modals/exception.dart';

abstract class IShareService {
  Future<void> share(String title, String message);
}

class ShareService implements IShareService {
  const ShareService();
  @override
  Future<void> share(String title, String message) async {
    try {
      var result = Share.share(message, subject: title);
      return result;
    } catch (ex) {
      print("sahre error ${ex.toString()}");
      Future.error(AppException(
          type: AppException.PLATFORM_EXCEPTION, message: ex.toString()));
    }
  }
}
