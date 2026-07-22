// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      studentId: json['studentId'] as String,
      departmentId: json['departmentId'] as String?,
      departmentName: json['departmentName'] as String?,
      level: (json['level'] as num?)?.toInt(),
      sectionId: json['sectionId'] as String?,
      sectionName: json['sectionName'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      deviceId: json['deviceId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'studentId': instance.studentId,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'level': instance.level,
      'sectionId': instance.sectionId,
      'sectionName': instance.sectionName,
      'phone': instance.phone,
      'photo': instance.photo,
      'deviceId': instance.deviceId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateStudentRequestImpl _$$CreateStudentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateStudentRequestImpl(
      name: json['name'] as String,
      studentId: json['studentId'] as String,
      departmentId: json['departmentId'] as String?,
      level: (json['level'] as num?)?.toInt(),
      sectionId: json['sectionId'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$CreateStudentRequestImplToJson(
        _$CreateStudentRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'studentId': instance.studentId,
      'departmentId': instance.departmentId,
      'level': instance.level,
      'sectionId': instance.sectionId,
      'phone': instance.phone,
      'photo': instance.photo,
    };

_$UpdateStudentRequestImpl _$$UpdateStudentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateStudentRequestImpl(
      name: json['name'] as String?,
      studentId: json['studentId'] as String?,
      departmentId: json['departmentId'] as String?,
      level: (json['level'] as num?)?.toInt(),
      sectionId: json['sectionId'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$UpdateStudentRequestImplToJson(
        _$UpdateStudentRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'studentId': instance.studentId,
      'departmentId': instance.departmentId,
      'level': instance.level,
      'sectionId': instance.sectionId,
      'phone': instance.phone,
      'photo': instance.photo,
    };
