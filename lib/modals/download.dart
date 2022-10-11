import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:zmare/utils/constants.dart';
part 'download.g.dart';

@JsonSerializable()
class Download {
  int? id;
  String? taskId;
  String? fileId;
  String? name;
  String? url;
  String? location;
  DownloadStatus? status;
  DownloadType? type;
  String? typeId;
  String? typeName;
  String? image;
  String? artistNames;
  int? progress;

  DateTime? date;

  Download(
      {this.id,
      this.taskId,
      this.fileId,
      this.name,
      this.status,
      this.url,
      this.location,
      this.type,
      this.typeId,
      this.typeName,
      this.artistNames,
      this.image,
      this.date,
      this.progress});

  factory Download.fromJson(Map<String, dynamic> data) =>
      _$DownloadFromJson(data);

  Map<String, dynamic> toJson() => _$DownloadToJson(this);
}

class DownloadProgress {
  String? id;
  int progress;
  DownloadStatus status;

  DownloadProgress({this.id, required this.progress, required this.status});
}
