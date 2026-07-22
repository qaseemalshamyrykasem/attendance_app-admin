/// نموذج الجلسة
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required String courseId,
    String? courseName,
    required String sectionId,
    String? sectionName,
    required DateTime date,
    required DateTime startTime,
    DateTime? endTime,
    @Default('created') String status,
    String? ip,
    int? port,
    String? token,
    String? qrData,
    String? createdById,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? connectedCount,
    int? attendanceCount,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}

/// نموذج لإنشاء جلسة جديدة
@freezed
class CreateSessionRequest with _$CreateSessionRequest {
  const factory CreateSessionRequest({
    required String courseId,
    required String sectionId,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    int? port,
  }) = _CreateSessionRequest;

  factory CreateSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSessionRequestFromJson(json);
}

/// معلومات الجلسة للـ API
@freezed
class SessionInfo with _$SessionInfo {
  const factory SessionInfo({
    required String id,
    required String courseName,
    required String sectionName,
    required DateTime date,
    required DateTime startTime,
    required String status,
    required String ip,
    required int port,
    required String token,
    required String qrData,
    required int connectedCount,
    required int attendanceCount,
  }) = _SessionInfo;

  factory SessionInfo.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoFromJson(json);
}
