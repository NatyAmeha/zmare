import 'package:zema/utils/constants.dart';

class DownloadViewmodel {
  String title;
  String subtitle;
  List<String> images;
  DownloadStatus status;
  double size;
  double progress;

  DownloadViewmodel({
    required this.title,
    required this.subtitle,
    required this.images,
    this.status = DownloadStatus.DOWNLOAD_NOT_STARTED,
    this.size = 0,
    this.progress = 0,
  });
}
