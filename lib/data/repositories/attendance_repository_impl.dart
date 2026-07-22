/// تنفيذ مستودع الحضور - يربط قاعدة البيانات بالطبقة الدومين
library;

import 'package:drift/drift.dart' as drift;
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../services/database/local_database.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AppDatabase _database;

  AttendanceRepositoryImpl(this._database);

  @override
  Future<List<AttendanceEntity>> getSessionAttendance(String sessionId) async {
    final records = await _database.getSessionAttendance(sessionId);
    return records.map((r) => _toEntity(r)).toList();
  }

  @override
  Future<bool> isStudentCheckedIn(String sessionId, String studentId) async {
    return await _database.isStudentCheckedIn(sessionId, studentId);
  }

  @override
  Future<AttendanceEntity> checkIn(AttendanceEntity attendance) async {
    final companion = AttendanceRecordsCompanion(
      id: drift.Value(attendance.id),
      sessionId: drift.Value(attendance.sessionId),
      studentId: drift.Value(attendance.studentId),
      timestamp: drift.Value(attendance.timestamp),
      status: drift.Value(attendance.status),
      deviceId: drift.Value(attendance.deviceId),
      hash: drift.Value(attendance.hash),
    );
    await _database.insertAttendanceRecord(companion);
    return attendance;
  }

  @override
  Future<AttendanceEntity> updateAttendance(AttendanceEntity attendance) async {
    // Drift uses replace for updates
    final existing = await _database.getSessionAttendance(attendance.sessionId);
    final record = existing.firstWhere(
      (r) => r.id == attendance.id,
      orElse: () => throw Exception('سجل الحضور غير موجود'),
    );
    final updated = record.copyWith(
      status: attendance.status,
      deviceId: attendance.deviceId ?? record.deviceId,
      hash: attendance.hash ?? record.hash,
    );
    await _database.updateAttendanceRecord(updated);
    return attendance;
  }

  @override
  Future<List<AttendanceEntity>> getStudentAttendanceHistory(String studentId) async {
    final records = await _database.getStudentAttendanceHistory(studentId);
    return records.map((r) => _toEntity(r)).toList();
  }

  @override
  Future<AttendanceStats> getSessionAttendanceStats(String sessionId) async {
    return await _database.getSessionAttendanceStats(sessionId);
  }

  /// تحويل نموذج قاعدة البيانات إلى كيان الدومين
  AttendanceEntity _toEntity(AttendanceRecord record) {
    return AttendanceEntity(
      id: record.id,
      sessionId: record.sessionId,
      studentId: record.studentId,
      timestamp: record.timestamp,
      status: record.status,
      deviceId: record.deviceId,
      hash: record.hash,
    );
  }
}
