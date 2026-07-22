// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String?,
      sectionId: json['sectionId'] as String,
      sectionName: json['sectionName'] as String?,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: json['status'] as String? ?? 'created',
      ip: json['ip'] as String?,
      port: (json['port'] as num?)?.toInt(),
      token: json['token'] as String?,
      qrData: json['qrData'] as String?,
      createdById: json['createdById'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      connectedCount: (json['connectedCount'] as num?)?.toInt(),
      attendanceCount: (json['attendanceCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'sectionId': instance.sectionId,
      'sectionName': instance.sectionName,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'ip': instance.ip,
      'port': instance.port,
      'token': instance.token,
      'qrData': instance.qrData,
      'createdById': instance.createdById,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'connectedCount': instance.connectedCount,
      'attendanceCount': instance.attendanceCount,
    };

_$CreateSessionRequestImpl _$$CreateSessionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateSessionRequestImpl(
      courseId: json['courseId'] as String,
      sectionId: json['sectionId'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CreateSessionRequestImplToJson(
        _$CreateSessionRequestImpl instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'sectionId': instance.sectionId,
      'date': instance.date?.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'port': instance.port,
    };

_$SessionInfoImpl _$$SessionInfoImplFromJson(Map<String, dynamic> json) =>
    _$SessionInfoImpl(
      id: json['id'] as String,
      courseName: json['courseName'] as String,
      sectionName: json['sectionName'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      status: json['status'] as String,
      ip: json['ip'] as String,
      port: (json['port'] as num).toInt(),
      token: json['token'] as String,
      qrData: json['qrData'] as String,
      connectedCount: (json['connectedCount'] as num).toInt(),
      attendanceCount: (json['attendanceCount'] as num).toInt(),
    );

Map<String, dynamic> _$$SessionInfoImplToJson(_$SessionInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseName': instance.courseName,
      'sectionName': instance.sectionName,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'status': instance.status,
      'ip': instance.ip,
      'port': instance.port,
      'token': instance.token,
      'qrData': instance.qrData,
      'connectedCount': instance.connectedCount,
      'attendanceCount': instance.attendanceCount,
    };
