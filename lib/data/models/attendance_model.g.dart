// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceImpl _$$AttendanceImplFromJson(Map<String, dynamic> json) =>
    _$AttendanceImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      studentId: json['studentId'] as String,
      student: json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String? ?? 'present',
      deviceId: json['deviceId'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$$AttendanceImplToJson(_$AttendanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'studentId': instance.studentId,
      'student': instance.student,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'deviceId': instance.deviceId,
      'hash': instance.hash,
    };

_$CheckInRequestModelImpl _$$CheckInRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckInRequestModelImpl(
      studentId: json['studentId'] as String,
      sessionToken: json['sessionToken'] as String,
      deviceId: json['deviceId'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$$CheckInRequestModelImplToJson(
        _$CheckInRequestModelImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'sessionToken': instance.sessionToken,
      'deviceId': instance.deviceId,
      'hash': instance.hash,
    };

_$CheckInResponseImpl _$$CheckInResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckInResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String?,
      attendance: json['attendance'] == null
          ? null
          : Attendance.fromJson(json['attendance'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CheckInResponseImplToJson(
        _$CheckInResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'attendance': instance.attendance,
      'error': instance.error,
    };
