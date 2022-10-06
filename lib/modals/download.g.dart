// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Download _$DownloadFromJson(Map<String, dynamic> json) => Download(
      id: json['id'] as int?,
      taskId: json['taskId'] as String?,
      fileId: json['fileId'] as String?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$DownloadStatusEnumMap, json['status']),
      url: json['url'] as String?,
      location: json['location'] as String?,
      type: $enumDecodeNullable(_$DownloadTypeEnumMap, json['type']),
      typeId: json['typeId'] as String?,
      image: json['image'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$DownloadToJson(Download instance) => <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'fileId': instance.fileId,
      'name': instance.name,
      'url': instance.url,
      'location': instance.location,
      'status': _$DownloadStatusEnumMap[instance.status],
      'type': _$DownloadTypeEnumMap[instance.type],
      'typeId': instance.typeId,
      'image': instance.image,
      'date': instance.date?.toIso8601String(),
    };

const _$DownloadStatusEnumMap = {
  DownloadStatus.PAUSED: 'PAUSED',
  DownloadStatus.COMPLETED: 'COMPLETED',
  DownloadStatus.FAILED: 'FAILED',
  DownloadStatus.IN_PROGRESS: 'IN_PROGRESS',
  DownloadStatus.NOT_STARTED: 'NOT_STARTED',
};

const _$DownloadTypeEnumMap = {
  DownloadType.ALBUM: 'ALBUM',
  DownloadType.PLAYLIST: 'PLAYLIST',
  DownloadType.SINGLE: 'SINGLE',
};
