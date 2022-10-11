import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:zmare/utils/constants.dart';

class Helper {
  static DownloadStatus converttoDownloadStatus(DownloadTaskStatus status) {
    DownloadStatus st;
    switch (status.value) {
      case 1:
        st = DownloadStatus.NOT_STARTED;
        break;
      case 2:
        st = DownloadStatus.IN_PROGRESS;
        break;
      case 3:
        st = DownloadStatus.COMPLETED;
        break;
      case 4:
        st = DownloadStatus.FAILED;
        break;
      case 6:
        st = DownloadStatus.PAUSED;
        break;
      default:
        st = DownloadStatus.NOT_STARTED;
        break;
    }
    return st;
  }
}
