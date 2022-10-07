import 'package:zema/modals/song.dart';

abstract class IDownloadService {
  Future<List<String?>> start(List<Song> songs, String path);
  Future<String?> startSingle(Song song, String path);
  Future<void> pause(List<String> id);
  Future<void> resume(List<String> id);
  Future<void> stop(List<String> id);
  Future<void> removeDownloads(List<String> id);
  Stream<int> getDownloadProgress(String taskId);
}
