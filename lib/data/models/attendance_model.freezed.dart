// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Attendance _$AttendanceFromJson(Map<String, dynamic> json) {
  return _Attendance.fromJson(json);
}

/// @nodoc
mixin _$Attendance {
  String get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  Student? get student => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get hash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceCopyWith<Attendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceCopyWith<$Res> {
  factory $AttendanceCopyWith(
          Attendance value, $Res Function(Attendance) then) =
      _$AttendanceCopyWithImpl<$Res, Attendance>;
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String studentId,
      Student? student,
      DateTime timestamp,
      String status,
      String? deviceId,
      String? hash});

  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class _$AttendanceCopyWithImpl<$Res, $Val extends Attendance>
    implements $AttendanceCopyWith<$Res> {
  _$AttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? studentId = null,
    Object? student = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? deviceId = freezed,
    Object? hash = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StudentCopyWith<$Res>? get student {
    if (_value.student == null) {
      return null;
    }

    return $StudentCopyWith<$Res>(_value.student!, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttendanceImplCopyWith<$Res>
    implements $AttendanceCopyWith<$Res> {
  factory _$$AttendanceImplCopyWith(
          _$AttendanceImpl value, $Res Function(_$AttendanceImpl) then) =
      __$$AttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sessionId,
      String studentId,
      Student? student,
      DateTime timestamp,
      String status,
      String? deviceId,
      String? hash});

  @override
  $StudentCopyWith<$Res>? get student;
}

/// @nodoc
class __$$AttendanceImplCopyWithImpl<$Res>
    extends _$AttendanceCopyWithImpl<$Res, _$AttendanceImpl>
    implements _$$AttendanceImplCopyWith<$Res> {
  __$$AttendanceImplCopyWithImpl(
      _$AttendanceImpl _value, $Res Function(_$AttendanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? studentId = null,
    Object? student = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? deviceId = freezed,
    Object? hash = freezed,
  }) {
    return _then(_$AttendanceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      student: freezed == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as Student?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceImpl implements _Attendance {
  const _$AttendanceImpl(
      {required this.id,
      required this.sessionId,
      required this.studentId,
      this.student,
      required this.timestamp,
      this.status = 'present',
      this.deviceId,
      this.hash});

  factory _$AttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceImplFromJson(json);

  @override
  final String id;
  @override
  final String sessionId;
  @override
  final String studentId;
  @override
  final Student? student;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final String status;
  @override
  final String? deviceId;
  @override
  final String? hash;

  @override
  String toString() {
    return 'Attendance(id: $id, sessionId: $sessionId, studentId: $studentId, student: $student, timestamp: $timestamp, status: $status, deviceId: $deviceId, hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, sessionId, studentId,
      student, timestamp, status, deviceId, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      __$$AttendanceImplCopyWithImpl<_$AttendanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceImplToJson(
      this,
    );
  }
}

abstract class _Attendance implements Attendance {
  const factory _Attendance(
      {required final String id,
      required final String sessionId,
      required final String studentId,
      final Student? student,
      required final DateTime timestamp,
      final String status,
      final String? deviceId,
      final String? hash}) = _$AttendanceImpl;

  factory _Attendance.fromJson(Map<String, dynamic> json) =
      _$AttendanceImpl.fromJson;

  @override
  String get id;
  @override
  String get sessionId;
  @override
  String get studentId;
  @override
  Student? get student;
  @override
  DateTime get timestamp;
  @override
  String get status;
  @override
  String? get deviceId;
  @override
  String? get hash;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckInRequestModel _$CheckInRequestModelFromJson(Map<String, dynamic> json) {
  return _CheckInRequestModel.fromJson(json);
}

/// @nodoc
mixin _$CheckInRequestModel {
  String get studentId => throw _privateConstructorUsedError;
  String get sessionToken => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get hash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckInRequestModelCopyWith<CheckInRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInRequestModelCopyWith<$Res> {
  factory $CheckInRequestModelCopyWith(
          CheckInRequestModel value, $Res Function(CheckInRequestModel) then) =
      _$CheckInRequestModelCopyWithImpl<$Res, CheckInRequestModel>;
  @useResult
  $Res call(
      {String studentId, String sessionToken, String? deviceId, String? hash});
}

/// @nodoc
class _$CheckInRequestModelCopyWithImpl<$Res, $Val extends CheckInRequestModel>
    implements $CheckInRequestModelCopyWith<$Res> {
  _$CheckInRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? sessionToken = null,
    Object? deviceId = freezed,
    Object? hash = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: null == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckInRequestModelImplCopyWith<$Res>
    implements $CheckInRequestModelCopyWith<$Res> {
  factory _$$CheckInRequestModelImplCopyWith(_$CheckInRequestModelImpl value,
          $Res Function(_$CheckInRequestModelImpl) then) =
      __$$CheckInRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId, String sessionToken, String? deviceId, String? hash});
}

/// @nodoc
class __$$CheckInRequestModelImplCopyWithImpl<$Res>
    extends _$CheckInRequestModelCopyWithImpl<$Res, _$CheckInRequestModelImpl>
    implements _$$CheckInRequestModelImplCopyWith<$Res> {
  __$$CheckInRequestModelImplCopyWithImpl(_$CheckInRequestModelImpl _value,
      $Res Function(_$CheckInRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? sessionToken = null,
    Object? deviceId = freezed,
    Object? hash = freezed,
  }) {
    return _then(_$CheckInRequestModelImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: null == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckInRequestModelImpl implements _CheckInRequestModel {
  const _$CheckInRequestModelImpl(
      {required this.studentId,
      required this.sessionToken,
      this.deviceId,
      this.hash});

  factory _$CheckInRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckInRequestModelImplFromJson(json);

  @override
  final String studentId;
  @override
  final String sessionToken;
  @override
  final String? deviceId;
  @override
  final String? hash;

  @override
  String toString() {
    return 'CheckInRequestModel(studentId: $studentId, sessionToken: $sessionToken, deviceId: $deviceId, hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInRequestModelImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, studentId, sessionToken, deviceId, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInRequestModelImplCopyWith<_$CheckInRequestModelImpl> get copyWith =>
      __$$CheckInRequestModelImplCopyWithImpl<_$CheckInRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckInRequestModelImplToJson(
      this,
    );
  }
}

abstract class _CheckInRequestModel implements CheckInRequestModel {
  const factory _CheckInRequestModel(
      {required final String studentId,
      required final String sessionToken,
      final String? deviceId,
      final String? hash}) = _$CheckInRequestModelImpl;

  factory _CheckInRequestModel.fromJson(Map<String, dynamic> json) =
      _$CheckInRequestModelImpl.fromJson;

  @override
  String get studentId;
  @override
  String get sessionToken;
  @override
  String? get deviceId;
  @override
  String? get hash;
  @override
  @JsonKey(ignore: true)
  _$$CheckInRequestModelImplCopyWith<_$CheckInRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckInResponse _$CheckInResponseFromJson(Map<String, dynamic> json) {
  return _CheckInResponse.fromJson(json);
}

/// @nodoc
mixin _$CheckInResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Attendance? get attendance => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckInResponseCopyWith<CheckInResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInResponseCopyWith<$Res> {
  factory $CheckInResponseCopyWith(
          CheckInResponse value, $Res Function(CheckInResponse) then) =
      _$CheckInResponseCopyWithImpl<$Res, CheckInResponse>;
  @useResult
  $Res call(
      {bool success, String? message, Attendance? attendance, String? error});

  $AttendanceCopyWith<$Res>? get attendance;
}

/// @nodoc
class _$CheckInResponseCopyWithImpl<$Res, $Val extends CheckInResponse>
    implements $CheckInResponseCopyWith<$Res> {
  _$CheckInResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? attendance = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as Attendance?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttendanceCopyWith<$Res>? get attendance {
    if (_value.attendance == null) {
      return null;
    }

    return $AttendanceCopyWith<$Res>(_value.attendance!, (value) {
      return _then(_value.copyWith(attendance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckInResponseImplCopyWith<$Res>
    implements $CheckInResponseCopyWith<$Res> {
  factory _$$CheckInResponseImplCopyWith(_$CheckInResponseImpl value,
          $Res Function(_$CheckInResponseImpl) then) =
      __$$CheckInResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String? message, Attendance? attendance, String? error});

  @override
  $AttendanceCopyWith<$Res>? get attendance;
}

/// @nodoc
class __$$CheckInResponseImplCopyWithImpl<$Res>
    extends _$CheckInResponseCopyWithImpl<$Res, _$CheckInResponseImpl>
    implements _$$CheckInResponseImplCopyWith<$Res> {
  __$$CheckInResponseImplCopyWithImpl(
      _$CheckInResponseImpl _value, $Res Function(_$CheckInResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? attendance = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CheckInResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as Attendance?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckInResponseImpl implements _CheckInResponse {
  const _$CheckInResponseImpl(
      {required this.success, this.message, this.attendance, this.error});

  factory _$CheckInResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckInResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  @override
  final Attendance? attendance;
  @override
  final String? error;

  @override
  String toString() {
    return 'CheckInResponse(success: $success, message: $message, attendance: $attendance, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, attendance, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInResponseImplCopyWith<_$CheckInResponseImpl> get copyWith =>
      __$$CheckInResponseImplCopyWithImpl<_$CheckInResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckInResponseImplToJson(
      this,
    );
  }
}

abstract class _CheckInResponse implements CheckInResponse {
  const factory _CheckInResponse(
      {required final bool success,
      final String? message,
      final Attendance? attendance,
      final String? error}) = _$CheckInResponseImpl;

  factory _CheckInResponse.fromJson(Map<String, dynamic> json) =
      _$CheckInResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  Attendance? get attendance;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$CheckInResponseImplCopyWith<_$CheckInResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
