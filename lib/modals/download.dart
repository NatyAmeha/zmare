import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:zema/utils/constants.dart';
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
  String? image;
  DateTime? date;

  Download({
    this.id,
    this.taskId,
    this.fileId,
    this.name,
    this.status,
    this.url,
    this.location,
    this.type,
    this.typeId,
    this.image,
    this.date,
  });

  factory Download.fromJson(Map<String, dynamic> data) =>
      _$DownloadFromJson(data);

  Map<String, dynamic> toJson() => _$DownloadToJson(this);
}
