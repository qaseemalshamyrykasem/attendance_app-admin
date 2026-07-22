/// نماذج المقررات والشعب والأقسام والمستويات
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_models.freezed.dart';
part 'organization_models.g.dart';

// ============================================
// القسم (Department)
// ============================================

@freezed
class Department with _$Department {
  const factory Department({
    required String id,
    required String name,
    String? code,
    DateTime? createdAt,
    int? studentsCount,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}

@freezed
class CreateDepartmentRequest with _$CreateDepartmentRequest {
  const factory CreateDepartmentRequest({
    required String name,
    String? code,
  }) = _CreateDepartmentRequest;

  factory CreateDepartmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDepartmentRequestFromJson(json);
}

// ============================================
// المستوى (Level)
// ============================================

@freezed
class Level with _$Level {
  const factory Level({
    required String id,
    required String name,
    String? code,
    int? order,
    DateTime? createdAt,
  }) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}

// ============================================
// الشعبة (Section)
// ============================================

@freezed
class Section with _$Section {
  const factory Section({
    required String id,
    required String name,
    String? levelId,
    String? levelName,
    String? departmentId,
    String? departmentName,
    DateTime? createdAt,
    int? studentsCount,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}

@freezed
class CreateSectionRequest with _$CreateSectionRequest {
  const factory CreateSectionRequest({
    required String name,
    String? levelId,
    String? departmentId,
  }) = _CreateSectionRequest;

  factory CreateSectionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSectionRequestFromJson(json);
}

// ============================================
// المقرر (Course)
// ============================================

@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String name,
    String? code,
    String? sectionId,
    String? sectionName,
    DateTime? createdAt,
    int? sessionsCount,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

@freezed
class CreateCourseRequest with _$CreateCourseRequest {
  const factory CreateCourseRequest({
    required String name,
    String? code,
    String? sectionId,
  }) = _CreateCourseRequest;

  factory CreateCourseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCourseRequestFromJson(json);
}
