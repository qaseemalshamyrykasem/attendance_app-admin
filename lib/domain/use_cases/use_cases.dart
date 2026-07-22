/// حالات الاستخدام (Use Cases)
library;

import '../entities/entities.dart';
import '../repositories/repositories.dart';

// ============================================
// حالات استخدام الطلاب
// ============================================

/// الحصول على قائمة الطلاب
class GetStudentsUseCase {
  final StudentRepository _repository;

  GetStudentsUseCase(this._repository);

  Future<List<StudentEntity>> call({String? query, String? sectionId}) async {
    if (query != null && query.isNotEmpty) {
      return _repository.searchStudents(query);
    }
    if (sectionId != null) {
      return _repository.getStudentsBySection(sectionId);
    }
    return _repository.getAllStudents();
  }
}

/// إضافة طالب جديد
class AddStudentUseCase {
  final StudentRepository _repository;

  AddStudentUseCase(this._repository);

  Future<StudentEntity> call(StudentEntity student) async {
    // التحقق من عدم وجود طالب بنفس الرقم
    final existing = await _repository.getStudentByStudentId(student.studentId);
    if (existing != null) {
      throw Exception('رقم الطالب موجود مسبقاً');
    }
    return _repository.addStudent(student);
  }
}

/// تحديث بيانات طالب
class UpdateStudentUseCase {
  final StudentRepository _repository;

  UpdateStudentUseCase(this._repository);

  Future<StudentEntity> call(StudentEntity student) async {
    return _repository.updateStudent(student);
  }
}

/// حذف طالب
class DeleteStudentUseCase {
  final StudentRepository _repository;

  DeleteStudentUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteStudent(id);
  }
}

// ============================================
// حالات استخدام الحضور
// ============================================

/// تسجيل حضور
class CheckInUseCase {
  final AttendanceRepository _attendanceRepo;
  final SessionRepository _sessionRepo;

  CheckInUseCase(this._attendanceRepo, this._sessionRepo);

  Future<AttendanceEntity> call({
    required String sessionId,
    required String studentId,
    String? deviceId,
    String? hash,
  }) async {
    // التحقق من أن الجلسة نشطة
    final session = await _sessionRepo.getSessionById(sessionId);
    if (session == null) {
      throw Exception('الجلسة غير موجودة');
    }
    if (session.status != 'active') {
      throw Exception('الجلسة غير نشطة');
    }

    // التحقق من عدم تسجيل الحضور مسبقاً
    final alreadyCheckedIn = await _attendanceRepo.isStudentCheckedIn(sessionId, studentId);
    if (alreadyCheckedIn) {
      throw Exception('تم تسجيل الحضور مسبقاً');
    }

    // إنشاء سجل الحضور
    final attendance = AttendanceEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sessionId: sessionId,
      studentId: studentId,
      timestamp: DateTime.now(),
      status: 'present',
      deviceId: deviceId,
      hash: hash,
    );

    return _attendanceRepo.checkIn(attendance);
  }
}

/// الحصول على إحصائيات جلسة
class GetSessionStatsUseCase {
  final AttendanceRepository _repository;

  GetSessionStatsUseCase(this._repository);

  Future<AttendanceStats> call(String sessionId) async {
    return _repository.getSessionAttendanceStats(sessionId);
  }
}

// ============================================
// حالات استخدام الجلسات
// ============================================

/// إنشاء جلسة جديدة
class CreateSessionUseCase {
  final SessionRepository _repository;

  CreateSessionUseCase(this._repository);

  Future<SessionEntity> call(SessionEntity session) async {
    return _repository.createSession(session);
  }
}

/// إغلاق جلسة
class CloseSessionUseCase {
  final SessionRepository _repository;

  CloseSessionUseCase(this._repository);

  Future<SessionEntity> call(String sessionId) async {
    return _repository.closeSession(sessionId);
  }
}

/// الحصول على الجلسة النشطة
class GetActiveSessionUseCase {
  final SessionRepository _repository;

  GetActiveSessionUseCase(this._repository);

  Future<List<SessionEntity>> call() async {
    return _repository.getActiveSessions();
  }
}
