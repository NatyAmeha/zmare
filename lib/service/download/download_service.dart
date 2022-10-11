import 'package:zmare/modals/song.dart';

abstract class IDownloadService {
  Future<List<String?>> start(List<Song> songs, String path);
  Future<String?> startSingle(Song song, String path);
  Future<void> pause(String id);
  Future<String?> resume(String id);
  Future<void> stop(List<String> id);
  Future<void> removeDownload(String id);
  Stream<int> getDownloadProgress(String taskId);
}
