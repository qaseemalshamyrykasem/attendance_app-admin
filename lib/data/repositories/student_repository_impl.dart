/// تنفيذ مستودع الطلاب - يربط قاعدة البيانات بالطبقة الدومين
library;

import 'package:drift/drift.dart' as drift;
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../services/database/local_database.dart';

class StudentRepositoryImpl implements StudentRepository {
  final AppDatabase _database;

  StudentRepositoryImpl(this._database);

  @override
  Future<List<StudentEntity>> getAllStudents() async {
    final students = await _database.getAllStudents();
    return students.map(_toEntity).toList();
  }

  @override
  Future<StudentEntity?> getStudentById(String id) async {
    final student = await _database.getStudentById(id);
    return student != null ? _toEntity(student) : null;
  }

  @override
  Future<StudentEntity?> getStudentByStudentId(String studentId) async {
    final student = await _database.getStudentByStudentId(studentId);
    return student != null ? _toEntity(student) : null;
  }

  @override
  Future<List<StudentEntity>> getStudentsByDepartment(String departmentId) async {
    final students = await _database.getStudentsByDepartment(departmentId);
    return students.map(_toEntity).toList();
  }

  @override
  Future<List<StudentEntity>> getStudentsBySection(String sectionId) async {
    final students = await _database.getStudentsBySection(sectionId);
    return students.map(_toEntity).toList();
  }

  @override
  Future<List<StudentEntity>> searchStudents(String query) async {
    final students = await _database.searchStudents(query);
    return students.map(_toEntity).toList();
  }

  @override
  Future<StudentEntity> addStudent(StudentEntity student) async {
    final companion = StudentsCompanion(
      id: drift.Value(student.id),
      name: drift.Value(student.name),
      studentId: drift.Value(student.studentId),
      departmentId: drift.Value(student.departmentId),
      level: drift.Value(student.level),
      sectionId: drift.Value(student.sectionId),
      phone: drift.Value(student.phone),
      photo: drift.Value(student.photo),
      createdAt: drift.Value(student.createdAt ?? DateTime.now()),
    );
    await _database.insertStudent(companion);
    return student;
  }

  @override
  Future<StudentEntity> updateStudent(StudentEntity student) async {
    final dbStudent = await _database.getStudentById(student.id);
    if (dbStudent == null) {
      throw Exception('الطالب غير موجود');
    }
    final updated = dbStudent.copyWith(
      name: student.name,
      studentId: student.studentId,
      departmentId: student.departmentId ?? dbStudent.departmentId,
      level: student.level ?? dbStudent.level,
      sectionId: student.sectionId ?? dbStudent.sectionId,
      phone: student.phone ?? dbStudent.phone,
      photo: student.photo ?? dbStudent.photo,
      updatedAt: DateTime.now(),
    );
    await _database.updateStudent(updated);
    return _toEntity(updated);
  }

  @override
  Future<void> deleteStudent(String id) async {
    await _database.deleteStudent(id);
  }

  @override
  Future<int> getStudentsCount() async {
    return await _database.getStudentsCount();
  }

  /// تحويل نموذج قاعدة البيانات إلى كيان الدومين
  StudentEntity _toEntity(Student student) {
    return StudentEntity(
      id: student.id,
      name: student.name,
      studentId: student.studentId,
      departmentId: student.departmentId,
      level: student.level,
      sectionId: student.sectionId,
      phone: student.phone,
      photo: student.photo,
      createdAt: student.createdAt,
      updatedAt: student.updatedAt,
    );
  }
}
