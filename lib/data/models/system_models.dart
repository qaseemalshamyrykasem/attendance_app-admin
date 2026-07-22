/// نماذج الإعدادات والسجل والنسخ الاحتياطي
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_models.freezed.dart';
part 'system_models.g.dart';

// ============================================
// الإعدادات (Setting)
// ============================================

@freezed
class AppSetting with _$AppSetting {
  const factory AppSetting({
    required String key,
    required String value,
    @Default('string') String type,
    DateTime? updatedAt,
  }) = _AppSetting;

  factory AppSetting.fromJson(Map<String, dynamic> json) =>
      _$AppSettingFromJson(json);
}

// ============================================
// السجل (Log)
// ============================================

@freezed
class LogEntry with _$LogEntry {
  const factory LogEntry({
    required String id,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, dynamic>? details,
    String? userId,
    required DateTime timestamp,
  }) = _LogEntry;

  factory LogEntry.fromJson(Map<String, dynamic> json) =>
      _$LogEntryFromJson(json);
}

// ============================================
// النسخة الاحتياطية (Backup)
// ============================================

@freezed
class BackupRecord with _$BackupRecord {
  const factory BackupRecord({
    required String id,
    required String filePath,
    required int size,
    required int recordsCount,
    DateTime? createdAt,
    String? description,
  }) = _BackupRecord;

  factory BackupRecord.fromJson(Map<String, dynamic> json) =>
      _$BackupRecordFromJson(json);
}

// ============================================
// إحصائيات التقرير
// ============================================

@freezed
class ReportStats with _$ReportStats {
  const factory ReportStats({
    required String period,
    required int totalStudents,
    required int totalSessions,
    required int presentCount,
    required int absentCount,
    required int lateCount,
    required int excusedCount,
    required double attendanceRate,
    List<CourseStats>? courseStats,
    List<DailyStats>? dailyStats,
  }) = _ReportStats;

  factory ReportStats.fromJson(Map<String, dynamic> json) =>
      _$ReportStatsFromJson(json);
}

@freezed
class CourseStats with _$CourseStats {
  const factory CourseStats({
    required String courseId,
    required String courseName,
    required int sessionsCount,
    required int avgAttendance,
    required List<SessionAttendanceSummary> sessions,
  }) = _CourseStats;

  factory CourseStats.fromJson(Map<String, dynamic> json) =>
      _$CourseStatsFromJson(json);
}

@freezed
class DailyStats with _$DailyStats {
  const factory DailyStats({
    required DateTime date,
    required int presentCount,
    required int absentCount,
    required int lateCount,
    required int excusedCount,
  }) = _DailyStats;

  factory DailyStats.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsFromJson(json);
}

@freezed
class SessionAttendanceSummary with _$SessionAttendanceSummary {
  const factory SessionAttendanceSummary({
    required String sessionId,
    required DateTime date,
    required int presentCount,
    required int absentCount,
    required int totalCount,
  }) = _SessionAttendanceSummary;

  factory SessionAttendanceSummary.fromJson(Map<String, dynamic> json) =>
      _$SessionAttendanceSummaryFromJson(json);
}
