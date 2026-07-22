/// الكيانات الأساسية للنظام
library;

// ============================================
// كيان الطالب
// ============================================

/// كيان الطالب - يمثل بيانات الطالب في النظام
class StudentEntity {
  final String id;
  final String name;
  final String studentId;
  final String? departmentId;
  final String? departmentName;
  final int? level;
  final String? sectionId;
  final String? sectionName;
  final String? phone;
  final String? photo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.studentId,
    this.departmentId,
    this.departmentName,
    this.level,
    this.sectionId,
    this.sectionName,
    this.phone,
    this.photo,
    this.createdAt,
    this.updatedAt,
  });
}

// ============================================
// كيان الحضور
// ============================================

/// كيان الحضور - يمثل تسجيل حضور طالب
class AttendanceEntity {
  final String id;
  final String sessionId;
  final String studentId;
  final StudentEntity? student;
  final DateTime timestamp;
  final String status;
  final String? deviceId;
  final String? hash;

  const AttendanceEntity({
    required this.id,
    required this.sessionId,
    required this.studentId,
    this.student,
    required this.timestamp,
    this.status = 'present',
    this.deviceId,
    this.hash,
  });
}

// ============================================
// كيان الجلسة
// ============================================

/// كيان الجلسة - يمثل جلسة حضور
class SessionEntity {
  final String id;
  final String courseId;
  final String? courseName;
  final String sectionId;
  final String? sectionName;
  final DateTime date;
  final DateTime startTime;
  final DateTime? endTime;
  final String status;
  final String? ip;
  final int? port;
  final String? token;
  final String? qrData;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SessionEntity({
    required this.id,
    required this.courseId,
    this.courseName,
    required this.sectionId,
    this.sectionName,
    required this.date,
    required this.startTime,
    this.endTime,
    this.status = 'created',
    this.ip,
    this.port,
    this.token,
    this.qrData,
    this.createdAt,
    this.updatedAt,
  });
}
