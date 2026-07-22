/// نموذج الحضور
library;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'student_model.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class Attendance with _$Attendance {
  const factory Attendance({
    required String id,
    required String sessionId,
    required String studentId,
    Student? student,
    required DateTime timestamp,
    @Default('present') String status,
    String? deviceId,
    String? hash,
  }) = _Attendance;

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
}

/// نموذج لتسجيل حضور جديد
@freezed
class CheckInRequestModel with _$CheckInRequestModel {
  const factory CheckInRequestModel({
    required String studentId,
    required String sessionToken,
    String? deviceId,
    String? hash,
  }) = _CheckInRequestModel;

  factory CheckInRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestModelFromJson(json);
}

/// استجابة تسجيل الحضور
@freezed
class CheckInResponse with _$CheckInResponse {
  const factory CheckInResponse({
    required bool success,
    String? message,
    Attendance? attendance,
    String? error,
  }) = _CheckInResponse;

  factory CheckInResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseFromJson(json);
}
