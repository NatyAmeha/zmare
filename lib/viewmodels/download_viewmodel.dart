import 'package:zema/modals/download.dart';
import 'package:zema/utils/constants.dart';

class DownloadViewmodel {
  String title;
  String subtitle;
  List<String> images;
  List<Download> downloads;
  DownloadStatus status;
  double size;
  double progress;

  DownloadViewmodel({
    required this.title,
    required this.subtitle,
    required this.images,
    required this.downloads,
    this.status = DownloadStatus.NOT_STARTED,
    this.size = 0,
    this.progress = 0,
  });
}
