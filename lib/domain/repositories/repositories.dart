/// واجهات المستودعات (Repositories)
library;

import '../entities/entities.dart';

// ============================================
// مستودع الطلاب
// ============================================

/// واجهة مستودع الطلاب
abstract class StudentRepository {
  /// الحصول على جميع الطلاب
  Future<List<StudentEntity>> getAllStudents();

  /// البحث عن طالب بالمعرف
  Future<StudentEntity?> getStudentById(String id);

  /// البحث عن طالب برقم الطالب
  Future<StudentEntity?> getStudentByStudentId(String studentId);

  /// البحث عن طلاب بقسم معين
  Future<List<StudentEntity>> getStudentsByDepartment(String departmentId);

  /// البحث عن طلاب بشعبة معينة
  Future<List<StudentEntity>> getStudentsBySection(String sectionId);

  /// بحث عن طالب بالاسم أو الرقم
  Future<List<StudentEntity>> searchStudents(String query);

  /// إضافة طالب جديد
  Future<StudentEntity> addStudent(StudentEntity student);

  /// تحديث بيانات طالب
  Future<StudentEntity> updateStudent(StudentEntity student);

  /// حذف طالب
  Future<void> deleteStudent(String id);

  /// الحصول على عدد الطلاب
  Future<int> getStudentsCount();
}

// ============================================
// مستودع الحضور
// ============================================

/// واجهة مستودع الحضور
abstract class AttendanceRepository {
  /// الحصول على حضور جلسة معينة
  Future<List<AttendanceEntity>> getSessionAttendance(String sessionId);

  /// التحقق من تسجيل حضور الطالب في الجلسة
  Future<bool> isStudentCheckedIn(String sessionId, String studentId);

  /// تسجيل حضور جديد
  Future<AttendanceEntity> checkIn(AttendanceEntity attendance);

  /// تحديث حالة الحضور
  Future<AttendanceEntity> updateAttendance(AttendanceEntity attendance);

  /// الحصول على حضور طالب في جميع الجلسات
  Future<List<AttendanceEntity>> getStudentAttendanceHistory(String studentId);

  /// الحصول على إحصائيات الحضور لجلسة
  Future<AttendanceStats> getSessionAttendanceStats(String sessionId);
}

/// بيانات إحصائيات الحضور
class AttendanceStats {
  final int totalCount;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;

  const AttendanceStats({
    required this.totalCount,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
  });

  double get presentRate => totalCount > 0 ? (presentCount / totalCount) * 100 : 0;
  double get absentRate => totalCount > 0 ? (absentCount / totalCount) * 100 : 0;
  double get lateRate => totalCount > 0 ? (lateCount / totalCount) * 100 : 0;
  double get excusedRate => totalCount > 0 ? (excusedCount / totalCount) * 100 : 0;
}

// ============================================
// مستودع الجلسات
// ============================================

/// واجهة مستودع الجلسات
abstract class SessionRepository {
  /// الحصول على جميع الجلسات
  Future<List<SessionEntity>> getAllSessions();

  /// الحصول على الجلسات النشطة
  Future<List<SessionEntity>> getActiveSessions();

  /// الحصول على جلسة بالمعرف
  Future<SessionEntity?> getSessionById(String id);

  /// الحصول على جلسة بالتوكن
  Future<SessionEntity?> getSessionByToken(String token);

  /// إنشاء جلسة جديدة
  Future<SessionEntity> createSession(SessionEntity session);

  /// تحديث جلسة
  Future<SessionEntity> updateSession(SessionEntity session);

  /// إغلاق جلسة
  Future<SessionEntity> closeSession(String id);
}

// ============================================
// مستودع الإعدادات
// ============================================

/// واجهة مستودع الإعدادات
abstract class SettingsRepository {
  /// الحصول على إعداد
  Future<String?> getSetting(String key);

  /// حفظ إعداد
  Future<void> setSetting(String key, String value);

  /// حذف إعداد
  Future<void> deleteSetting(String key);

  /// الحصول على جميع الإعدادات
  Future<Map<String, String>> getAllSettings();
}
