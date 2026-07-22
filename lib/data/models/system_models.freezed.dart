// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSetting _$AppSettingFromJson(Map<String, dynamic> json) {
  return _AppSetting.fromJson(json);
}

/// @nodoc
mixin _$AppSetting {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingCopyWith<AppSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingCopyWith<$Res> {
  factory $AppSettingCopyWith(
          AppSetting value, $Res Function(AppSetting) then) =
      _$AppSettingCopyWithImpl<$Res, AppSetting>;
  @useResult
  $Res call({String key, String value, String type, DateTime? updatedAt});
}

/// @nodoc
class _$AppSettingCopyWithImpl<$Res, $Val extends AppSetting>
    implements $AppSettingCopyWith<$Res> {
  _$AppSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? type = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingImplCopyWith<$Res>
    implements $AppSettingCopyWith<$Res> {
  factory _$$AppSettingImplCopyWith(
          _$AppSettingImpl value, $Res Function(_$AppSettingImpl) then) =
      __$$AppSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value, String type, DateTime? updatedAt});
}

/// @nodoc
class __$$AppSettingImplCopyWithImpl<$Res>
    extends _$AppSettingCopyWithImpl<$Res, _$AppSettingImpl>
    implements _$$AppSettingImplCopyWith<$Res> {
  __$$AppSettingImplCopyWithImpl(
      _$AppSettingImpl _value, $Res Function(_$AppSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? type = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AppSettingImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingImpl implements _AppSetting {
  const _$AppSettingImpl(
      {required this.key,
      required this.value,
      this.type = 'string',
      this.updatedAt});

  factory _$AppSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingImplFromJson(json);

  @override
  final String key;
  @override
  final String value;
  @override
  @JsonKey()
  final String type;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AppSetting(key: $key, value: $value, type: $type, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value, type, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingImplCopyWith<_$AppSettingImpl> get copyWith =>
      __$$AppSettingImplCopyWithImpl<_$AppSettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingImplToJson(
      this,
    );
  }
}

abstract class _AppSetting implements AppSetting {
  const factory _AppSetting(
      {required final String key,
      required final String value,
      final String type,
      final DateTime? updatedAt}) = _$AppSettingImpl;

  factory _AppSetting.fromJson(Map<String, dynamic> json) =
      _$AppSettingImpl.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  String get type;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingImplCopyWith<_$AppSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LogEntry _$LogEntryFromJson(Map<String, dynamic> json) {
  return _LogEntry.fromJson(json);
}

/// @nodoc
mixin _$LogEntry {
  String get id => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String? get entityId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogEntryCopyWith<LogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogEntryCopyWith<$Res> {
  factory $LogEntryCopyWith(LogEntry value, $Res Function(LogEntry) then) =
      _$LogEntryCopyWithImpl<$Res, LogEntry>;
  @useResult
  $Res call(
      {String id,
      String action,
      String entityType,
      String? entityId,
      Map<String, dynamic>? details,
      String? userId,
      DateTime timestamp});
}

/// @nodoc
class _$LogEntryCopyWithImpl<$Res, $Val extends LogEntry>
    implements $LogEntryCopyWith<$Res> {
  _$LogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? entityType = null,
    Object? entityId = freezed,
    Object? details = freezed,
    Object? userId = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogEntryImplCopyWith<$Res>
    implements $LogEntryCopyWith<$Res> {
  factory _$$LogEntryImplCopyWith(
          _$LogEntryImpl value, $Res Function(_$LogEntryImpl) then) =
      __$$LogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String action,
      String entityType,
      String? entityId,
      Map<String, dynamic>? details,
      String? userId,
      DateTime timestamp});
}

/// @nodoc
class __$$LogEntryImplCopyWithImpl<$Res>
    extends _$LogEntryCopyWithImpl<$Res, _$LogEntryImpl>
    implements _$$LogEntryImplCopyWith<$Res> {
  __$$LogEntryImplCopyWithImpl(
      _$LogEntryImpl _value, $Res Function(_$LogEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? entityType = null,
    Object? entityId = freezed,
    Object? details = freezed,
    Object? userId = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$LogEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogEntryImpl implements _LogEntry {
  const _$LogEntryImpl(
      {required this.id,
      required this.action,
      required this.entityType,
      this.entityId,
      final Map<String, dynamic>? details,
      this.userId,
      required this.timestamp})
      : _details = details;

  factory _$LogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String action;
  @override
  final String entityType;
  @override
  final String? entityId;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? userId;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'LogEntry(id: $id, action: $action, entityType: $entityType, entityId: $entityId, details: $details, userId: $userId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, entityType, entityId,
      const DeepCollectionEquality().hash(_details), userId, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogEntryImplCopyWith<_$LogEntryImpl> get copyWith =>
      __$$LogEntryImplCopyWithImpl<_$LogEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogEntryImplToJson(
      this,
    );
  }
}

abstract class _LogEntry implements LogEntry {
  const factory _LogEntry(
      {required final String id,
      required final String action,
      required final String entityType,
      final String? entityId,
      final Map<String, dynamic>? details,
      final String? userId,
      required final DateTime timestamp}) = _$LogEntryImpl;

  factory _LogEntry.fromJson(Map<String, dynamic> json) =
      _$LogEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get action;
  @override
  String get entityType;
  @override
  String? get entityId;
  @override
  Map<String, dynamic>? get details;
  @override
  String? get userId;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$LogEntryImplCopyWith<_$LogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BackupRecord _$BackupRecordFromJson(Map<String, dynamic> json) {
  return _BackupRecord.fromJson(json);
}

/// @nodoc
mixin _$BackupRecord {
  String get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  int get recordsCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BackupRecordCopyWith<BackupRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupRecordCopyWith<$Res> {
  factory $BackupRecordCopyWith(
          BackupRecord value, $Res Function(BackupRecord) then) =
      _$BackupRecordCopyWithImpl<$Res, BackupRecord>;
  @useResult
  $Res call(
      {String id,
      String filePath,
      int size,
      int recordsCount,
      DateTime? createdAt,
      String? description});
}

/// @nodoc
class _$BackupRecordCopyWithImpl<$Res, $Val extends BackupRecord>
    implements $BackupRecordCopyWith<$Res> {
  _$BackupRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? size = null,
    Object? recordsCount = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      recordsCount: null == recordsCount
          ? _value.recordsCount
          : recordsCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BackupRecordImplCopyWith<$Res>
    implements $BackupRecordCopyWith<$Res> {
  factory _$$BackupRecordImplCopyWith(
          _$BackupRecordImpl value, $Res Function(_$BackupRecordImpl) then) =
      __$$BackupRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String filePath,
      int size,
      int recordsCount,
      DateTime? createdAt,
      String? description});
}

/// @nodoc
class __$$BackupRecordImplCopyWithImpl<$Res>
    extends _$BackupRecordCopyWithImpl<$Res, _$BackupRecordImpl>
    implements _$$BackupRecordImplCopyWith<$Res> {
  __$$BackupRecordImplCopyWithImpl(
      _$BackupRecordImpl _value, $Res Function(_$BackupRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? size = null,
    Object? recordsCount = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_$BackupRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      recordsCount: null == recordsCount
          ? _value.recordsCount
          : recordsCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BackupRecordImpl implements _BackupRecord {
  const _$BackupRecordImpl(
      {required this.id,
      required this.filePath,
      required this.size,
      required this.recordsCount,
      this.createdAt,
      this.description});

  factory _$BackupRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$BackupRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String filePath;
  @override
  final int size;
  @override
  final int recordsCount;
  @override
  final DateTime? createdAt;
  @override
  final String? description;

  @override
  String toString() {
    return 'BackupRecord(id: $id, filePath: $filePath, size: $size, recordsCount: $recordsCount, createdAt: $createdAt, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.recordsCount, recordsCount) ||
                other.recordsCount == recordsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, filePath, size, recordsCount, createdAt, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupRecordImplCopyWith<_$BackupRecordImpl> get copyWith =>
      __$$BackupRecordImplCopyWithImpl<_$BackupRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BackupRecordImplToJson(
      this,
    );
  }
}

abstract class _BackupRecord implements BackupRecord {
  const factory _BackupRecord(
      {required final String id,
      required final String filePath,
      required final int size,
      required final int recordsCount,
      final DateTime? createdAt,
      final String? description}) = _$BackupRecordImpl;

  factory _BackupRecord.fromJson(Map<String, dynamic> json) =
      _$BackupRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get filePath;
  @override
  int get size;
  @override
  int get recordsCount;
  @override
  DateTime? get createdAt;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$BackupRecordImplCopyWith<_$BackupRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportStats _$ReportStatsFromJson(Map<String, dynamic> json) {
  return _ReportStats.fromJson(json);
}

/// @nodoc
mixin _$ReportStats {
  String get period => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  int get totalSessions => throw _privateConstructorUsedError;
  int get presentCount => throw _privateConstructorUsedError;
  int get absentCount => throw _privateConstructorUsedError;
  int get lateCount => throw _privateConstructorUsedError;
  int get excusedCount => throw _privateConstructorUsedError;
  double get attendanceRate => throw _privateConstructorUsedError;
  List<CourseStats>? get courseStats => throw _privateConstructorUsedError;
  List<DailyStats>? get dailyStats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportStatsCopyWith<ReportStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportStatsCopyWith<$Res> {
  factory $ReportStatsCopyWith(
          ReportStats value, $Res Function(ReportStats) then) =
      _$ReportStatsCopyWithImpl<$Res, ReportStats>;
  @useResult
  $Res call(
      {String period,
      int totalStudents,
      int totalSessions,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount,
      double attendanceRate,
      List<CourseStats>? courseStats,
      List<DailyStats>? dailyStats});
}

/// @nodoc
class _$ReportStatsCopyWithImpl<$Res, $Val extends ReportStats>
    implements $ReportStatsCopyWith<$Res> {
  _$ReportStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? totalStudents = null,
    Object? totalSessions = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
    Object? attendanceRate = null,
    Object? courseStats = freezed,
    Object? dailyStats = freezed,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceRate: null == attendanceRate
          ? _value.attendanceRate
          : attendanceRate // ignore: cast_nullable_to_non_nullable
              as double,
      courseStats: freezed == courseStats
          ? _value.courseStats
          : courseStats // ignore: cast_nullable_to_non_nullable
              as List<CourseStats>?,
      dailyStats: freezed == dailyStats
          ? _value.dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as List<DailyStats>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportStatsImplCopyWith<$Res>
    implements $ReportStatsCopyWith<$Res> {
  factory _$$ReportStatsImplCopyWith(
          _$ReportStatsImpl value, $Res Function(_$ReportStatsImpl) then) =
      __$$ReportStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String period,
      int totalStudents,
      int totalSessions,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount,
      double attendanceRate,
      List<CourseStats>? courseStats,
      List<DailyStats>? dailyStats});
}

/// @nodoc
class __$$ReportStatsImplCopyWithImpl<$Res>
    extends _$ReportStatsCopyWithImpl<$Res, _$ReportStatsImpl>
    implements _$$ReportStatsImplCopyWith<$Res> {
  __$$ReportStatsImplCopyWithImpl(
      _$ReportStatsImpl _value, $Res Function(_$ReportStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? totalStudents = null,
    Object? totalSessions = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
    Object? attendanceRate = null,
    Object? courseStats = freezed,
    Object? dailyStats = freezed,
  }) {
    return _then(_$ReportStatsImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceRate: null == attendanceRate
          ? _value.attendanceRate
          : attendanceRate // ignore: cast_nullable_to_non_nullable
              as double,
      courseStats: freezed == courseStats
          ? _value._courseStats
          : courseStats // ignore: cast_nullable_to_non_nullable
              as List<CourseStats>?,
      dailyStats: freezed == dailyStats
          ? _value._dailyStats
          : dailyStats // ignore: cast_nullable_to_non_nullable
              as List<DailyStats>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportStatsImpl implements _ReportStats {
  const _$ReportStatsImpl(
      {required this.period,
      required this.totalStudents,
      required this.totalSessions,
      required this.presentCount,
      required this.absentCount,
      required this.lateCount,
      required this.excusedCount,
      required this.attendanceRate,
      final List<CourseStats>? courseStats,
      final List<DailyStats>? dailyStats})
      : _courseStats = courseStats,
        _dailyStats = dailyStats;

  factory _$ReportStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportStatsImplFromJson(json);

  @override
  final String period;
  @override
  final int totalStudents;
  @override
  final int totalSessions;
  @override
  final int presentCount;
  @override
  final int absentCount;
  @override
  final int lateCount;
  @override
  final int excusedCount;
  @override
  final double attendanceRate;
  final List<CourseStats>? _courseStats;
  @override
  List<CourseStats>? get courseStats {
    final value = _courseStats;
    if (value == null) return null;
    if (_courseStats is EqualUnmodifiableListView) return _courseStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DailyStats>? _dailyStats;
  @override
  List<DailyStats>? get dailyStats {
    final value = _dailyStats;
    if (value == null) return null;
    if (_dailyStats is EqualUnmodifiableListView) return _dailyStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReportStats(period: $period, totalStudents: $totalStudents, totalSessions: $totalSessions, presentCount: $presentCount, absentCount: $absentCount, lateCount: $lateCount, excusedCount: $excusedCount, attendanceRate: $attendanceRate, courseStats: $courseStats, dailyStats: $dailyStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportStatsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.presentCount, presentCount) ||
                other.presentCount == presentCount) &&
            (identical(other.absentCount, absentCount) ||
                other.absentCount == absentCount) &&
            (identical(other.lateCount, lateCount) ||
                other.lateCount == lateCount) &&
            (identical(other.excusedCount, excusedCount) ||
                other.excusedCount == excusedCount) &&
            (identical(other.attendanceRate, attendanceRate) ||
                other.attendanceRate == attendanceRate) &&
            const DeepCollectionEquality()
                .equals(other._courseStats, _courseStats) &&
            const DeepCollectionEquality()
                .equals(other._dailyStats, _dailyStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      totalStudents,
      totalSessions,
      presentCount,
      absentCount,
      lateCount,
      excusedCount,
      attendanceRate,
      const DeepCollectionEquality().hash(_courseStats),
      const DeepCollectionEquality().hash(_dailyStats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportStatsImplCopyWith<_$ReportStatsImpl> get copyWith =>
      __$$ReportStatsImplCopyWithImpl<_$ReportStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportStatsImplToJson(
      this,
    );
  }
}

abstract class _ReportStats implements ReportStats {
  const factory _ReportStats(
      {required final String period,
      required final int totalStudents,
      required final int totalSessions,
      required final int presentCount,
      required final int absentCount,
      required final int lateCount,
      required final int excusedCount,
      required final double attendanceRate,
      final List<CourseStats>? courseStats,
      final List<DailyStats>? dailyStats}) = _$ReportStatsImpl;

  factory _ReportStats.fromJson(Map<String, dynamic> json) =
      _$ReportStatsImpl.fromJson;

  @override
  String get period;
  @override
  int get totalStudents;
  @override
  int get totalSessions;
  @override
  int get presentCount;
  @override
  int get absentCount;
  @override
  int get lateCount;
  @override
  int get excusedCount;
  @override
  double get attendanceRate;
  @override
  List<CourseStats>? get courseStats;
  @override
  List<DailyStats>? get dailyStats;
  @override
  @JsonKey(ignore: true)
  _$$ReportStatsImplCopyWith<_$ReportStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseStats _$CourseStatsFromJson(Map<String, dynamic> json) {
  return _CourseStats.fromJson(json);
}

/// @nodoc
mixin _$CourseStats {
  String get courseId => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  int get sessionsCount => throw _privateConstructorUsedError;
  int get avgAttendance => throw _privateConstructorUsedError;
  List<SessionAttendanceSummary> get sessions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseStatsCopyWith<CourseStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseStatsCopyWith<$Res> {
  factory $CourseStatsCopyWith(
          CourseStats value, $Res Function(CourseStats) then) =
      _$CourseStatsCopyWithImpl<$Res, CourseStats>;
  @useResult
  $Res call(
      {String courseId,
      String courseName,
      int sessionsCount,
      int avgAttendance,
      List<SessionAttendanceSummary> sessions});
}

/// @nodoc
class _$CourseStatsCopyWithImpl<$Res, $Val extends CourseStats>
    implements $CourseStatsCopyWith<$Res> {
  _$CourseStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseName = null,
    Object? sessionsCount = null,
    Object? avgAttendance = null,
    Object? sessions = null,
  }) {
    return _then(_value.copyWith(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      sessionsCount: null == sessionsCount
          ? _value.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgAttendance: null == avgAttendance
          ? _value.avgAttendance
          : avgAttendance // ignore: cast_nullable_to_non_nullable
              as int,
      sessions: null == sessions
          ? _value.sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendanceSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseStatsImplCopyWith<$Res>
    implements $CourseStatsCopyWith<$Res> {
  factory _$$CourseStatsImplCopyWith(
          _$CourseStatsImpl value, $Res Function(_$CourseStatsImpl) then) =
      __$$CourseStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String courseId,
      String courseName,
      int sessionsCount,
      int avgAttendance,
      List<SessionAttendanceSummary> sessions});
}

/// @nodoc
class __$$CourseStatsImplCopyWithImpl<$Res>
    extends _$CourseStatsCopyWithImpl<$Res, _$CourseStatsImpl>
    implements _$$CourseStatsImplCopyWith<$Res> {
  __$$CourseStatsImplCopyWithImpl(
      _$CourseStatsImpl _value, $Res Function(_$CourseStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseName = null,
    Object? sessionsCount = null,
    Object? avgAttendance = null,
    Object? sessions = null,
  }) {
    return _then(_$CourseStatsImpl(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      sessionsCount: null == sessionsCount
          ? _value.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgAttendance: null == avgAttendance
          ? _value.avgAttendance
          : avgAttendance // ignore: cast_nullable_to_non_nullable
              as int,
      sessions: null == sessions
          ? _value._sessions
          : sessions // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendanceSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseStatsImpl implements _CourseStats {
  const _$CourseStatsImpl(
      {required this.courseId,
      required this.courseName,
      required this.sessionsCount,
      required this.avgAttendance,
      required final List<SessionAttendanceSummary> sessions})
      : _sessions = sessions;

  factory _$CourseStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseStatsImplFromJson(json);

  @override
  final String courseId;
  @override
  final String courseName;
  @override
  final int sessionsCount;
  @override
  final int avgAttendance;
  final List<SessionAttendanceSummary> _sessions;
  @override
  List<SessionAttendanceSummary> get sessions {
    if (_sessions is EqualUnmodifiableListView) return _sessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessions);
  }

  @override
  String toString() {
    return 'CourseStats(courseId: $courseId, courseName: $courseName, sessionsCount: $sessionsCount, avgAttendance: $avgAttendance, sessions: $sessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseStatsImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.sessionsCount, sessionsCount) ||
                other.sessionsCount == sessionsCount) &&
            (identical(other.avgAttendance, avgAttendance) ||
                other.avgAttendance == avgAttendance) &&
            const DeepCollectionEquality().equals(other._sessions, _sessions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      courseId,
      courseName,
      sessionsCount,
      avgAttendance,
      const DeepCollectionEquality().hash(_sessions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseStatsImplCopyWith<_$CourseStatsImpl> get copyWith =>
      __$$CourseStatsImplCopyWithImpl<_$CourseStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseStatsImplToJson(
      this,
    );
  }
}

abstract class _CourseStats implements CourseStats {
  const factory _CourseStats(
          {required final String courseId,
          required final String courseName,
          required final int sessionsCount,
          required final int avgAttendance,
          required final List<SessionAttendanceSummary> sessions}) =
      _$CourseStatsImpl;

  factory _CourseStats.fromJson(Map<String, dynamic> json) =
      _$CourseStatsImpl.fromJson;

  @override
  String get courseId;
  @override
  String get courseName;
  @override
  int get sessionsCount;
  @override
  int get avgAttendance;
  @override
  List<SessionAttendanceSummary> get sessions;
  @override
  @JsonKey(ignore: true)
  _$$CourseStatsImplCopyWith<_$CourseStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyStats _$DailyStatsFromJson(Map<String, dynamic> json) {
  return _DailyStats.fromJson(json);
}

/// @nodoc
mixin _$DailyStats {
  DateTime get date => throw _privateConstructorUsedError;
  int get presentCount => throw _privateConstructorUsedError;
  int get absentCount => throw _privateConstructorUsedError;
  int get lateCount => throw _privateConstructorUsedError;
  int get excusedCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyStatsCopyWith<DailyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyStatsCopyWith<$Res> {
  factory $DailyStatsCopyWith(
          DailyStats value, $Res Function(DailyStats) then) =
      _$DailyStatsCopyWithImpl<$Res, DailyStats>;
  @useResult
  $Res call(
      {DateTime date,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount});
}

/// @nodoc
class _$DailyStatsCopyWithImpl<$Res, $Val extends DailyStats>
    implements $DailyStatsCopyWith<$Res> {
  _$DailyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyStatsImplCopyWith<$Res>
    implements $DailyStatsCopyWith<$Res> {
  factory _$$DailyStatsImplCopyWith(
          _$DailyStatsImpl value, $Res Function(_$DailyStatsImpl) then) =
      __$$DailyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int presentCount,
      int absentCount,
      int lateCount,
      int excusedCount});
}

/// @nodoc
class __$$DailyStatsImplCopyWithImpl<$Res>
    extends _$DailyStatsCopyWithImpl<$Res, _$DailyStatsImpl>
    implements _$$DailyStatsImplCopyWith<$Res> {
  __$$DailyStatsImplCopyWithImpl(
      _$DailyStatsImpl _value, $Res Function(_$DailyStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? lateCount = null,
    Object? excusedCount = null,
  }) {
    return _then(_$DailyStatsImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lateCount: null == lateCount
          ? _value.lateCount
          : lateCount // ignore: cast_nullable_to_non_nullable
              as int,
      excusedCount: null == excusedCount
          ? _value.excusedCount
          : excusedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyStatsImpl implements _DailyStats {
  const _$DailyStatsImpl(
      {required this.date,
      required this.presentCount,
      required this.absentCount,
      required this.lateCount,
      required this.excusedCount});

  factory _$DailyStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyStatsImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int presentCount;
  @override
  final int absentCount;
  @override
  final int lateCount;
  @override
  final int excusedCount;

  @override
  String toString() {
    return 'DailyStats(date: $date, presentCount: $presentCount, absentCount: $absentCount, lateCount: $lateCount, excusedCount: $excusedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyStatsImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.presentCount, presentCount) ||
                other.presentCount == presentCount) &&
            (identical(other.absentCount, absentCount) ||
                other.absentCount == absentCount) &&
            (identical(other.lateCount, lateCount) ||
                other.lateCount == lateCount) &&
            (identical(other.excusedCount, excusedCount) ||
                other.excusedCount == excusedCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, presentCount, absentCount, lateCount, excusedCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      __$$DailyStatsImplCopyWithImpl<_$DailyStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyStatsImplToJson(
      this,
    );
  }
}

abstract class _DailyStats implements DailyStats {
  const factory _DailyStats(
      {required final DateTime date,
      required final int presentCount,
      required final int absentCount,
      required final int lateCount,
      required final int excusedCount}) = _$DailyStatsImpl;

  factory _DailyStats.fromJson(Map<String, dynamic> json) =
      _$DailyStatsImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get presentCount;
  @override
  int get absentCount;
  @override
  int get lateCount;
  @override
  int get excusedCount;
  @override
  @JsonKey(ignore: true)
  _$$DailyStatsImplCopyWith<_$DailyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionAttendanceSummary _$SessionAttendanceSummaryFromJson(
    Map<String, dynamic> json) {
  return _SessionAttendanceSummary.fromJson(json);
}

/// @nodoc
mixin _$SessionAttendanceSummary {
  String get sessionId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get presentCount => throw _privateConstructorUsedError;
  int get absentCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionAttendanceSummaryCopyWith<SessionAttendanceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAttendanceSummaryCopyWith<$Res> {
  factory $SessionAttendanceSummaryCopyWith(SessionAttendanceSummary value,
          $Res Function(SessionAttendanceSummary) then) =
      _$SessionAttendanceSummaryCopyWithImpl<$Res, SessionAttendanceSummary>;
  @useResult
  $Res call(
      {String sessionId,
      DateTime date,
      int presentCount,
      int absentCount,
      int totalCount});
}

/// @nodoc
class _$SessionAttendanceSummaryCopyWithImpl<$Res,
        $Val extends SessionAttendanceSummary>
    implements $SessionAttendanceSummaryCopyWith<$Res> {
  _$SessionAttendanceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? date = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionAttendanceSummaryImplCopyWith<$Res>
    implements $SessionAttendanceSummaryCopyWith<$Res> {
  factory _$$SessionAttendanceSummaryImplCopyWith(
          _$SessionAttendanceSummaryImpl value,
          $Res Function(_$SessionAttendanceSummaryImpl) then) =
      __$$SessionAttendanceSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      DateTime date,
      int presentCount,
      int absentCount,
      int totalCount});
}

/// @nodoc
class __$$SessionAttendanceSummaryImplCopyWithImpl<$Res>
    extends _$SessionAttendanceSummaryCopyWithImpl<$Res,
        _$SessionAttendanceSummaryImpl>
    implements _$$SessionAttendanceSummaryImplCopyWith<$Res> {
  __$$SessionAttendanceSummaryImplCopyWithImpl(
      _$SessionAttendanceSummaryImpl _value,
      $Res Function(_$SessionAttendanceSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? date = null,
    Object? presentCount = null,
    Object? absentCount = null,
    Object? totalCount = null,
  }) {
    return _then(_$SessionAttendanceSummaryImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      presentCount: null == presentCount
          ? _value.presentCount
          : presentCount // ignore: cast_nullable_to_non_nullable
              as int,
      absentCount: null == absentCount
          ? _value.absentCount
          : absentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionAttendanceSummaryImpl implements _SessionAttendanceSummary {
  const _$SessionAttendanceSummaryImpl(
      {required this.sessionId,
      required this.date,
      required this.presentCount,
      required this.absentCount,
      required this.totalCount});

  factory _$SessionAttendanceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionAttendanceSummaryImplFromJson(json);

  @override
  final String sessionId;
  @override
  final DateTime date;
  @override
  final int presentCount;
  @override
  final int absentCount;
  @override
  final int totalCount;

  @override
  String toString() {
    return 'SessionAttendanceSummary(sessionId: $sessionId, date: $date, presentCount: $presentCount, absentCount: $absentCount, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAttendanceSummaryImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.presentCount, presentCount) ||
                other.presentCount == presentCount) &&
            (identical(other.absentCount, absentCount) ||
                other.absentCount == absentCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sessionId, date, presentCount, absentCount, totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAttendanceSummaryImplCopyWith<_$SessionAttendanceSummaryImpl>
      get copyWith => __$$SessionAttendanceSummaryImplCopyWithImpl<
          _$SessionAttendanceSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionAttendanceSummaryImplToJson(
      this,
    );
  }
}

abstract class _SessionAttendanceSummary implements SessionAttendanceSummary {
  const factory _SessionAttendanceSummary(
      {required final String sessionId,
      required final DateTime date,
      required final int presentCount,
      required final int absentCount,
      required final int totalCount}) = _$SessionAttendanceSummaryImpl;

  factory _SessionAttendanceSummary.fromJson(Map<String, dynamic> json) =
      _$SessionAttendanceSummaryImpl.fromJson;

  @override
  String get sessionId;
  @override
  DateTime get date;
  @override
  int get presentCount;
  @override
  int get absentCount;
  @override
  int get totalCount;
  @override
  @JsonKey(ignore: true)
  _$$SessionAttendanceSummaryImplCopyWith<_$SessionAttendanceSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
