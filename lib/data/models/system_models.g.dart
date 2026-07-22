// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingImpl _$$AppSettingImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingImpl(
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String? ?? 'string',
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AppSettingImplToJson(_$AppSettingImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$LogEntryImpl _$$LogEntryImplFromJson(Map<String, dynamic> json) =>
    _$LogEntryImpl(
      id: json['id'] as String,
      action: json['action'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String?,
      details: json['details'] as Map<String, dynamic>?,
      userId: json['userId'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$LogEntryImplToJson(_$LogEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'details': instance.details,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$BackupRecordImpl _$$BackupRecordImplFromJson(Map<String, dynamic> json) =>
    _$BackupRecordImpl(
      id: json['id'] as String,
      filePath: json['filePath'] as String,
      size: (json['size'] as num).toInt(),
      recordsCount: (json['recordsCount'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$BackupRecordImplToJson(_$BackupRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'size': instance.size,
      'recordsCount': instance.recordsCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'description': instance.description,
    };

_$ReportStatsImpl _$$ReportStatsImplFromJson(Map<String, dynamic> json) =>
    _$ReportStatsImpl(
      period: json['period'] as String,
      totalStudents: (json['totalStudents'] as num).toInt(),
      totalSessions: (json['totalSessions'] as num).toInt(),
      presentCount: (json['presentCount'] as num).toInt(),
      absentCount: (json['absentCount'] as num).toInt(),
      lateCount: (json['lateCount'] as num).toInt(),
      excusedCount: (json['excusedCount'] as num).toInt(),
      attendanceRate: (json['attendanceRate'] as num).toDouble(),
      courseStats: (json['courseStats'] as List<dynamic>?)
          ?.map((e) => CourseStats.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyStats: (json['dailyStats'] as List<dynamic>?)
          ?.map((e) => DailyStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReportStatsImplToJson(_$ReportStatsImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'totalStudents': instance.totalStudents,
      'totalSessions': instance.totalSessions,
      'presentCount': instance.presentCount,
      'absentCount': instance.absentCount,
      'lateCount': instance.lateCount,
      'excusedCount': instance.excusedCount,
      'attendanceRate': instance.attendanceRate,
      'courseStats': instance.courseStats,
      'dailyStats': instance.dailyStats,
    };

_$CourseStatsImpl _$$CourseStatsImplFromJson(Map<String, dynamic> json) =>
    _$CourseStatsImpl(
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String,
      sessionsCount: (json['sessionsCount'] as num).toInt(),
      avgAttendance: (json['avgAttendance'] as num).toInt(),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) =>
              SessionAttendanceSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CourseStatsImplToJson(_$CourseStatsImpl instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'sessionsCount': instance.sessionsCount,
      'avgAttendance': instance.avgAttendance,
      'sessions': instance.sessions,
    };

_$DailyStatsImpl _$$DailyStatsImplFromJson(Map<String, dynamic> json) =>
    _$DailyStatsImpl(
      date: DateTime.parse(json['date'] as String),
      presentCount: (json['presentCount'] as num).toInt(),
      absentCount: (json['absentCount'] as num).toInt(),
      lateCount: (json['lateCount'] as num).toInt(),
      excusedCount: (json['excusedCount'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyStatsImplToJson(_$DailyStatsImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'presentCount': instance.presentCount,
      'absentCount': instance.absentCount,
      'lateCount': instance.lateCount,
      'excusedCount': instance.excusedCount,
    };

_$SessionAttendanceSummaryImpl _$$SessionAttendanceSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionAttendanceSummaryImpl(
      sessionId: json['sessionId'] as String,
      date: DateTime.parse(json['date'] as String),
      presentCount: (json['presentCount'] as num).toInt(),
      absentCount: (json['absentCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$$SessionAttendanceSummaryImplToJson(
        _$SessionAttendanceSummaryImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'date': instance.date.toIso8601String(),
      'presentCount': instance.presentCount,
      'absentCount': instance.absentCount,
      'totalCount': instance.totalCount,
    };
