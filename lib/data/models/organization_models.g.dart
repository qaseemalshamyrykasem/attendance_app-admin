// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DepartmentImpl _$$DepartmentImplFromJson(Map<String, dynamic> json) =>
    _$DepartmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      studentsCount: (json['studentsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DepartmentImplToJson(_$DepartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'createdAt': instance.createdAt?.toIso8601String(),
      'studentsCount': instance.studentsCount,
    };

_$CreateDepartmentRequestImpl _$$CreateDepartmentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateDepartmentRequestImpl(
      name: json['name'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$$CreateDepartmentRequestImplToJson(
        _$CreateDepartmentRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };

_$LevelImpl _$$LevelImplFromJson(Map<String, dynamic> json) => _$LevelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      order: (json['order'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LevelImplToJson(_$LevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'order': instance.order,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      levelId: json['levelId'] as String?,
      levelName: json['levelName'] as String?,
      departmentId: json['departmentId'] as String?,
      departmentName: json['departmentName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      studentsCount: (json['studentsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'levelId': instance.levelId,
      'levelName': instance.levelName,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'studentsCount': instance.studentsCount,
    };

_$CreateSectionRequestImpl _$$CreateSectionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateSectionRequestImpl(
      name: json['name'] as String,
      levelId: json['levelId'] as String?,
      departmentId: json['departmentId'] as String?,
    );

Map<String, dynamic> _$$CreateSectionRequestImplToJson(
        _$CreateSectionRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'levelId': instance.levelId,
      'departmentId': instance.departmentId,
    };

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      sectionId: json['sectionId'] as String?,
      sectionName: json['sectionName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      sessionsCount: (json['sessionsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'sectionId': instance.sectionId,
      'sectionName': instance.sectionName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'sessionsCount': instance.sessionsCount,
    };

_$CreateCourseRequestImpl _$$CreateCourseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateCourseRequestImpl(
      name: json['name'] as String,
      code: json['code'] as String?,
      sectionId: json['sectionId'] as String?,
    );

Map<String, dynamic> _$$CreateCourseRequestImplToJson(
        _$CreateCourseRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'sectionId': instance.sectionId,
    };
