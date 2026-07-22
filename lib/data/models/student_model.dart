/// نموذج الطالب
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String name,
    required String studentId,
    String? departmentId,
    String? departmentName,
    int? level,
    String? sectionId,
    String? sectionName,
    String? phone,
    String? photo,
    String? deviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
}

/// نموذج لإنشاء طالب جديد
@freezed
class CreateStudentRequest with _$CreateStudentRequest {
  const factory CreateStudentRequest({
    required String name,
    required String studentId,
    String? departmentId,
    int? level,
    String? sectionId,
    String? phone,
    String? photo,
  }) = _CreateStudentRequest;

  factory CreateStudentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStudentRequestFromJson(json);
}

/// نموذج لتحديث بيانات الطالب
@freezed
class UpdateStudentRequest with _$UpdateStudentRequest {
  const factory UpdateStudentRequest({
    String? name,
    String? studentId,
    String? departmentId,
    int? level,
    String? sectionId,
    String? phone,
    String? photo,
  }) = _UpdateStudentRequest;

  factory UpdateStudentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStudentRequestFromJson(json);
}
