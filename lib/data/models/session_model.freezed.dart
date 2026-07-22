// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String? get courseName => throw _privateConstructorUsedError;
  String get sectionId => throw _privateConstructorUsedError;
  String? get sectionName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get qrData => throw _privateConstructorUsedError;
  String? get createdById => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get connectedCount => throw _privateConstructorUsedError;
  int? get attendanceCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {String id,
      String courseId,
      String? courseName,
      String sectionId,
      String? sectionName,
      DateTime date,
      DateTime startTime,
      DateTime? endTime,
      String status,
      String? ip,
      int? port,
      String? token,
      String? qrData,
      String? createdById,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? connectedCount,
      int? attendanceCount});
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? courseName = freezed,
    Object? sectionId = null,
    Object? sectionName = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? ip = freezed,
    Object? port = freezed,
    Object? token = freezed,
    Object? qrData = freezed,
    Object? createdById = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? connectedCount = freezed,
    Object? attendanceCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: freezed == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      qrData: freezed == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      connectedCount: freezed == connectedCount
          ? _value.connectedCount
          : connectedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      attendanceCount: freezed == attendanceCount
          ? _value.attendanceCount
          : attendanceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String courseId,
      String? courseName,
      String sectionId,
      String? sectionName,
      DateTime date,
      DateTime startTime,
      DateTime? endTime,
      String status,
      String? ip,
      int? port,
      String? token,
      String? qrData,
      String? createdById,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? connectedCount,
      int? attendanceCount});
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? courseName = freezed,
    Object? sectionId = null,
    Object? sectionName = freezed,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? ip = freezed,
    Object? port = freezed,
    Object? token = freezed,
    Object? qrData = freezed,
    Object? createdById = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? connectedCount = freezed,
    Object? attendanceCount = freezed,
  }) {
    return _then(_$SessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: freezed == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      qrData: freezed == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      connectedCount: freezed == connectedCount
          ? _value.connectedCount
          : connectedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      attendanceCount: freezed == attendanceCount
          ? _value.attendanceCount
          : attendanceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl(
      {required this.id,
      required this.courseId,
      this.courseName,
      required this.sectionId,
      this.sectionName,
      required this.date,
      required this.startTime,
      this.endTime,
      this.status = 'created',
      this.ip,
      this.port,
      this.token,
      this.qrData,
      this.createdById,
      this.createdAt,
      this.updatedAt,
      this.connectedCount,
      this.attendanceCount});

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String? courseName;
  @override
  final String sectionId;
  @override
  final String? sectionName;
  @override
  final DateTime date;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  @JsonKey()
  final String status;
  @override
  final String? ip;
  @override
  final int? port;
  @override
  final String? token;
  @override
  final String? qrData;
  @override
  final String? createdById;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? connectedCount;
  @override
  final int? attendanceCount;

  @override
  String toString() {
    return 'Session(id: $id, courseId: $courseId, courseName: $courseName, sectionId: $sectionId, sectionName: $sectionName, date: $date, startTime: $startTime, endTime: $endTime, status: $status, ip: $ip, port: $port, token: $token, qrData: $qrData, createdById: $createdById, createdAt: $createdAt, updatedAt: $updatedAt, connectedCount: $connectedCount, attendanceCount: $attendanceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.qrData, qrData) || other.qrData == qrData) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.connectedCount, connectedCount) ||
                other.connectedCount == connectedCount) &&
            (identical(other.attendanceCount, attendanceCount) ||
                other.attendanceCount == attendanceCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      courseId,
      courseName,
      sectionId,
      sectionName,
      date,
      startTime,
      endTime,
      status,
      ip,
      port,
      token,
      qrData,
      createdById,
      createdAt,
      updatedAt,
      connectedCount,
      attendanceCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(
      this,
    );
  }
}

abstract class _Session implements Session {
  const factory _Session(
      {required final String id,
      required final String courseId,
      final String? courseName,
      required final String sectionId,
      final String? sectionName,
      required final DateTime date,
      required final DateTime startTime,
      final DateTime? endTime,
      final String status,
      final String? ip,
      final int? port,
      final String? token,
      final String? qrData,
      final String? createdById,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final int? connectedCount,
      final int? attendanceCount}) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String? get courseName;
  @override
  String get sectionId;
  @override
  String? get sectionName;
  @override
  DateTime get date;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  String get status;
  @override
  String? get ip;
  @override
  int? get port;
  @override
  String? get token;
  @override
  String? get qrData;
  @override
  String? get createdById;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int? get connectedCount;
  @override
  int? get attendanceCount;
  @override
  @JsonKey(ignore: true)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateSessionRequest _$CreateSessionRequestFromJson(Map<String, dynamic> json) {
  return _CreateSessionRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateSessionRequest {
  String get courseId => throw _privateConstructorUsedError;
  String get sectionId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateSessionRequestCopyWith<CreateSessionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSessionRequestCopyWith<$Res> {
  factory $CreateSessionRequestCopyWith(CreateSessionRequest value,
          $Res Function(CreateSessionRequest) then) =
      _$CreateSessionRequestCopyWithImpl<$Res, CreateSessionRequest>;
  @useResult
  $Res call(
      {String courseId,
      String sectionId,
      DateTime? date,
      DateTime? startTime,
      DateTime? endTime,
      int? port});
}

/// @nodoc
class _$CreateSessionRequestCopyWithImpl<$Res,
        $Val extends CreateSessionRequest>
    implements $CreateSessionRequestCopyWith<$Res> {
  _$CreateSessionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? sectionId = null,
    Object? date = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? port = freezed,
  }) {
    return _then(_value.copyWith(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSessionRequestImplCopyWith<$Res>
    implements $CreateSessionRequestCopyWith<$Res> {
  factory _$$CreateSessionRequestImplCopyWith(_$CreateSessionRequestImpl value,
          $Res Function(_$CreateSessionRequestImpl) then) =
      __$$CreateSessionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String courseId,
      String sectionId,
      DateTime? date,
      DateTime? startTime,
      DateTime? endTime,
      int? port});
}

/// @nodoc
class __$$CreateSessionRequestImplCopyWithImpl<$Res>
    extends _$CreateSessionRequestCopyWithImpl<$Res, _$CreateSessionRequestImpl>
    implements _$$CreateSessionRequestImplCopyWith<$Res> {
  __$$CreateSessionRequestImplCopyWithImpl(_$CreateSessionRequestImpl _value,
      $Res Function(_$CreateSessionRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? sectionId = null,
    Object? date = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? port = freezed,
  }) {
    return _then(_$CreateSessionRequestImpl(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSessionRequestImpl implements _CreateSessionRequest {
  const _$CreateSessionRequestImpl(
      {required this.courseId,
      required this.sectionId,
      this.date,
      this.startTime,
      this.endTime,
      this.port});

  factory _$CreateSessionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSessionRequestImplFromJson(json);

  @override
  final String courseId;
  @override
  final String sectionId;
  @override
  final DateTime? date;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? port;

  @override
  String toString() {
    return 'CreateSessionRequest(courseId: $courseId, sectionId: $sectionId, date: $date, startTime: $startTime, endTime: $endTime, port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSessionRequestImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, courseId, sectionId, date, startTime, endTime, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSessionRequestImplCopyWith<_$CreateSessionRequestImpl>
      get copyWith =>
          __$$CreateSessionRequestImplCopyWithImpl<_$CreateSessionRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSessionRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateSessionRequest implements CreateSessionRequest {
  const factory _CreateSessionRequest(
      {required final String courseId,
      required final String sectionId,
      final DateTime? date,
      final DateTime? startTime,
      final DateTime? endTime,
      final int? port}) = _$CreateSessionRequestImpl;

  factory _CreateSessionRequest.fromJson(Map<String, dynamic> json) =
      _$CreateSessionRequestImpl.fromJson;

  @override
  String get courseId;
  @override
  String get sectionId;
  @override
  DateTime? get date;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  int? get port;
  @override
  @JsonKey(ignore: true)
  _$$CreateSessionRequestImplCopyWith<_$CreateSessionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SessionInfo _$SessionInfoFromJson(Map<String, dynamic> json) {
  return _SessionInfo.fromJson(json);
}

/// @nodoc
mixin _$SessionInfo {
  String get id => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  String get sectionName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get qrData => throw _privateConstructorUsedError;
  int get connectedCount => throw _privateConstructorUsedError;
  int get attendanceCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionInfoCopyWith<SessionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionInfoCopyWith<$Res> {
  factory $SessionInfoCopyWith(
          SessionInfo value, $Res Function(SessionInfo) then) =
      _$SessionInfoCopyWithImpl<$Res, SessionInfo>;
  @useResult
  $Res call(
      {String id,
      String courseName,
      String sectionName,
      DateTime date,
      DateTime startTime,
      String status,
      String ip,
      int port,
      String token,
      String qrData,
      int connectedCount,
      int attendanceCount});
}

/// @nodoc
class _$SessionInfoCopyWithImpl<$Res, $Val extends SessionInfo>
    implements $SessionInfoCopyWith<$Res> {
  _$SessionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseName = null,
    Object? sectionName = null,
    Object? date = null,
    Object? startTime = null,
    Object? status = null,
    Object? ip = null,
    Object? port = null,
    Object? token = null,
    Object? qrData = null,
    Object? connectedCount = null,
    Object? attendanceCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      sectionName: null == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      qrData: null == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as String,
      connectedCount: null == connectedCount
          ? _value.connectedCount
          : connectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceCount: null == attendanceCount
          ? _value.attendanceCount
          : attendanceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionInfoImplCopyWith<$Res>
    implements $SessionInfoCopyWith<$Res> {
  factory _$$SessionInfoImplCopyWith(
          _$SessionInfoImpl value, $Res Function(_$SessionInfoImpl) then) =
      __$$SessionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String courseName,
      String sectionName,
      DateTime date,
      DateTime startTime,
      String status,
      String ip,
      int port,
      String token,
      String qrData,
      int connectedCount,
      int attendanceCount});
}

/// @nodoc
class __$$SessionInfoImplCopyWithImpl<$Res>
    extends _$SessionInfoCopyWithImpl<$Res, _$SessionInfoImpl>
    implements _$$SessionInfoImplCopyWith<$Res> {
  __$$SessionInfoImplCopyWithImpl(
      _$SessionInfoImpl _value, $Res Function(_$SessionInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseName = null,
    Object? sectionName = null,
    Object? date = null,
    Object? startTime = null,
    Object? status = null,
    Object? ip = null,
    Object? port = null,
    Object? token = null,
    Object? qrData = null,
    Object? connectedCount = null,
    Object? attendanceCount = null,
  }) {
    return _then(_$SessionInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      sectionName: null == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      qrData: null == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as String,
      connectedCount: null == connectedCount
          ? _value.connectedCount
          : connectedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceCount: null == attendanceCount
          ? _value.attendanceCount
          : attendanceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionInfoImpl implements _SessionInfo {
  const _$SessionInfoImpl(
      {required this.id,
      required this.courseName,
      required this.sectionName,
      required this.date,
      required this.startTime,
      required this.status,
      required this.ip,
      required this.port,
      required this.token,
      required this.qrData,
      required this.connectedCount,
      required this.attendanceCount});

  factory _$SessionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String courseName;
  @override
  final String sectionName;
  @override
  final DateTime date;
  @override
  final DateTime startTime;
  @override
  final String status;
  @override
  final String ip;
  @override
  final int port;
  @override
  final String token;
  @override
  final String qrData;
  @override
  final int connectedCount;
  @override
  final int attendanceCount;

  @override
  String toString() {
    return 'SessionInfo(id: $id, courseName: $courseName, sectionName: $sectionName, date: $date, startTime: $startTime, status: $status, ip: $ip, port: $port, token: $token, qrData: $qrData, connectedCount: $connectedCount, attendanceCount: $attendanceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.qrData, qrData) || other.qrData == qrData) &&
            (identical(other.connectedCount, connectedCount) ||
                other.connectedCount == connectedCount) &&
            (identical(other.attendanceCount, attendanceCount) ||
                other.attendanceCount == attendanceCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      courseName,
      sectionName,
      date,
      startTime,
      status,
      ip,
      port,
      token,
      qrData,
      connectedCount,
      attendanceCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionInfoImplCopyWith<_$SessionInfoImpl> get copyWith =>
      __$$SessionInfoImplCopyWithImpl<_$SessionInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionInfoImplToJson(
      this,
    );
  }
}

abstract class _SessionInfo implements SessionInfo {
  const factory _SessionInfo(
      {required final String id,
      required final String courseName,
      required final String sectionName,
      required final DateTime date,
      required final DateTime startTime,
      required final String status,
      required final String ip,
      required final int port,
      required final String token,
      required final String qrData,
      required final int connectedCount,
      required final int attendanceCount}) = _$SessionInfoImpl;

  factory _SessionInfo.fromJson(Map<String, dynamic> json) =
      _$SessionInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get courseName;
  @override
  String get sectionName;
  @override
  DateTime get date;
  @override
  DateTime get startTime;
  @override
  String get status;
  @override
  String get ip;
  @override
  int get port;
  @override
  String get token;
  @override
  String get qrData;
  @override
  int get connectedCount;
  @override
  int get attendanceCount;
  @override
  @JsonKey(ignore: true)
  _$$SessionInfoImplCopyWith<_$SessionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
