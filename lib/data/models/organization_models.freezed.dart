// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return _Department.fromJson(json);
}

/// @nodoc
mixin _$Department {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get studentsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentCopyWith<Department> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentCopyWith<$Res> {
  factory $DepartmentCopyWith(
          Department value, $Res Function(Department) then) =
      _$DepartmentCopyWithImpl<$Res, Department>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      DateTime? createdAt,
      int? studentsCount});
}

/// @nodoc
class _$DepartmentCopyWithImpl<$Res, $Val extends Department>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? studentsCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentsCount: freezed == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DepartmentImplCopyWith<$Res>
    implements $DepartmentCopyWith<$Res> {
  factory _$$DepartmentImplCopyWith(
          _$DepartmentImpl value, $Res Function(_$DepartmentImpl) then) =
      __$$DepartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      DateTime? createdAt,
      int? studentsCount});
}

/// @nodoc
class __$$DepartmentImplCopyWithImpl<$Res>
    extends _$DepartmentCopyWithImpl<$Res, _$DepartmentImpl>
    implements _$$DepartmentImplCopyWith<$Res> {
  __$$DepartmentImplCopyWithImpl(
      _$DepartmentImpl _value, $Res Function(_$DepartmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? studentsCount = freezed,
  }) {
    return _then(_$DepartmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentsCount: freezed == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DepartmentImpl implements _Department {
  const _$DepartmentImpl(
      {required this.id,
      required this.name,
      this.code,
      this.createdAt,
      this.studentsCount});

  factory _$DepartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DepartmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? code;
  @override
  final DateTime? createdAt;
  @override
  final int? studentsCount;

  @override
  String toString() {
    return 'Department(id: $id, name: $name, code: $code, createdAt: $createdAt, studentsCount: $studentsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepartmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.studentsCount, studentsCount) ||
                other.studentsCount == studentsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, code, createdAt, studentsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      __$$DepartmentImplCopyWithImpl<_$DepartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepartmentImplToJson(
      this,
    );
  }
}

abstract class _Department implements Department {
  const factory _Department(
      {required final String id,
      required final String name,
      final String? code,
      final DateTime? createdAt,
      final int? studentsCount}) = _$DepartmentImpl;

  factory _Department.fromJson(Map<String, dynamic> json) =
      _$DepartmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get code;
  @override
  DateTime? get createdAt;
  @override
  int? get studentsCount;
  @override
  @JsonKey(ignore: true)
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateDepartmentRequest _$CreateDepartmentRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateDepartmentRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateDepartmentRequest {
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDepartmentRequestCopyWith<CreateDepartmentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDepartmentRequestCopyWith<$Res> {
  factory $CreateDepartmentRequestCopyWith(CreateDepartmentRequest value,
          $Res Function(CreateDepartmentRequest) then) =
      _$CreateDepartmentRequestCopyWithImpl<$Res, CreateDepartmentRequest>;
  @useResult
  $Res call({String name, String? code});
}

/// @nodoc
class _$CreateDepartmentRequestCopyWithImpl<$Res,
        $Val extends CreateDepartmentRequest>
    implements $CreateDepartmentRequestCopyWith<$Res> {
  _$CreateDepartmentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateDepartmentRequestImplCopyWith<$Res>
    implements $CreateDepartmentRequestCopyWith<$Res> {
  factory _$$CreateDepartmentRequestImplCopyWith(
          _$CreateDepartmentRequestImpl value,
          $Res Function(_$CreateDepartmentRequestImpl) then) =
      __$$CreateDepartmentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? code});
}

/// @nodoc
class __$$CreateDepartmentRequestImplCopyWithImpl<$Res>
    extends _$CreateDepartmentRequestCopyWithImpl<$Res,
        _$CreateDepartmentRequestImpl>
    implements _$$CreateDepartmentRequestImplCopyWith<$Res> {
  __$$CreateDepartmentRequestImplCopyWithImpl(
      _$CreateDepartmentRequestImpl _value,
      $Res Function(_$CreateDepartmentRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
  }) {
    return _then(_$CreateDepartmentRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateDepartmentRequestImpl implements _CreateDepartmentRequest {
  const _$CreateDepartmentRequestImpl({required this.name, this.code});

  factory _$CreateDepartmentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateDepartmentRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String? code;

  @override
  String toString() {
    return 'CreateDepartmentRequest(name: $name, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDepartmentRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDepartmentRequestImplCopyWith<_$CreateDepartmentRequestImpl>
      get copyWith => __$$CreateDepartmentRequestImplCopyWithImpl<
          _$CreateDepartmentRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDepartmentRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateDepartmentRequest implements CreateDepartmentRequest {
  const factory _CreateDepartmentRequest(
      {required final String name,
      final String? code}) = _$CreateDepartmentRequestImpl;

  factory _CreateDepartmentRequest.fromJson(Map<String, dynamic> json) =
      _$CreateDepartmentRequestImpl.fromJson;

  @override
  String get name;
  @override
  String? get code;
  @override
  @JsonKey(ignore: true)
  _$$CreateDepartmentRequestImplCopyWith<_$CreateDepartmentRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Level _$LevelFromJson(Map<String, dynamic> json) {
  return _Level.fromJson(json);
}

/// @nodoc
mixin _$Level {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelCopyWith<Level> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelCopyWith<$Res> {
  factory $LevelCopyWith(Level value, $Res Function(Level) then) =
      _$LevelCopyWithImpl<$Res, Level>;
  @useResult
  $Res call(
      {String id, String name, String? code, int? order, DateTime? createdAt});
}

/// @nodoc
class _$LevelCopyWithImpl<$Res, $Val extends Level>
    implements $LevelCopyWith<$Res> {
  _$LevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? order = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelImplCopyWith<$Res> implements $LevelCopyWith<$Res> {
  factory _$$LevelImplCopyWith(
          _$LevelImpl value, $Res Function(_$LevelImpl) then) =
      __$$LevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, String? code, int? order, DateTime? createdAt});
}

/// @nodoc
class __$$LevelImplCopyWithImpl<$Res>
    extends _$LevelCopyWithImpl<$Res, _$LevelImpl>
    implements _$$LevelImplCopyWith<$Res> {
  __$$LevelImplCopyWithImpl(
      _$LevelImpl _value, $Res Function(_$LevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? order = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$LevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelImpl implements _Level {
  const _$LevelImpl(
      {required this.id,
      required this.name,
      this.code,
      this.order,
      this.createdAt});

  factory _$LevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? code;
  @override
  final int? order;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Level(id: $id, name: $name, code: $code, order: $order, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, code, order, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      __$$LevelImplCopyWithImpl<_$LevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelImplToJson(
      this,
    );
  }
}

abstract class _Level implements Level {
  const factory _Level(
      {required final String id,
      required final String name,
      final String? code,
      final int? order,
      final DateTime? createdAt}) = _$LevelImpl;

  factory _Level.fromJson(Map<String, dynamic> json) = _$LevelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get code;
  @override
  int? get order;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Section _$SectionFromJson(Map<String, dynamic> json) {
  return _Section.fromJson(json);
}

/// @nodoc
mixin _$Section {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get levelId => throw _privateConstructorUsedError;
  String? get levelName => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;
  String? get departmentName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get studentsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionCopyWith<Section> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) then) =
      _$SectionCopyWithImpl<$Res, Section>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? levelId,
      String? levelName,
      String? departmentId,
      String? departmentName,
      DateTime? createdAt,
      int? studentsCount});
}

/// @nodoc
class _$SectionCopyWithImpl<$Res, $Val extends Section>
    implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? createdAt = freezed,
    Object? studentsCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      levelName: freezed == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentName: freezed == departmentName
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentsCount: freezed == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionImplCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$$SectionImplCopyWith(
          _$SectionImpl value, $Res Function(_$SectionImpl) then) =
      __$$SectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? levelId,
      String? levelName,
      String? departmentId,
      String? departmentName,
      DateTime? createdAt,
      int? studentsCount});
}

/// @nodoc
class __$$SectionImplCopyWithImpl<$Res>
    extends _$SectionCopyWithImpl<$Res, _$SectionImpl>
    implements _$$SectionImplCopyWith<$Res> {
  __$$SectionImplCopyWithImpl(
      _$SectionImpl _value, $Res Function(_$SectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? levelId = freezed,
    Object? levelName = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? createdAt = freezed,
    Object? studentsCount = freezed,
  }) {
    return _then(_$SectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      levelName: freezed == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentName: freezed == departmentName
          ? _value.departmentName
          : departmentName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentsCount: freezed == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionImpl implements _Section {
  const _$SectionImpl(
      {required this.id,
      required this.name,
      this.levelId,
      this.levelName,
      this.departmentId,
      this.departmentName,
      this.createdAt,
      this.studentsCount});

  factory _$SectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? levelId;
  @override
  final String? levelName;
  @override
  final String? departmentId;
  @override
  final String? departmentName;
  @override
  final DateTime? createdAt;
  @override
  final int? studentsCount;

  @override
  String toString() {
    return 'Section(id: $id, name: $name, levelId: $levelId, levelName: $levelName, departmentId: $departmentId, departmentName: $departmentName, createdAt: $createdAt, studentsCount: $studentsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.departmentName, departmentName) ||
                other.departmentName == departmentName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.studentsCount, studentsCount) ||
                other.studentsCount == studentsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, levelId, levelName,
      departmentId, departmentName, createdAt, studentsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      __$$SectionImplCopyWithImpl<_$SectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionImplToJson(
      this,
    );
  }
}

abstract class _Section implements Section {
  const factory _Section(
      {required final String id,
      required final String name,
      final String? levelId,
      final String? levelName,
      final String? departmentId,
      final String? departmentName,
      final DateTime? createdAt,
      final int? studentsCount}) = _$SectionImpl;

  factory _Section.fromJson(Map<String, dynamic> json) = _$SectionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get levelId;
  @override
  String? get levelName;
  @override
  String? get departmentId;
  @override
  String? get departmentName;
  @override
  DateTime? get createdAt;
  @override
  int? get studentsCount;
  @override
  @JsonKey(ignore: true)
  _$$SectionImplCopyWith<_$SectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateSectionRequest _$CreateSectionRequestFromJson(Map<String, dynamic> json) {
  return _CreateSectionRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateSectionRequest {
  String get name => throw _privateConstructorUsedError;
  String? get levelId => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateSectionRequestCopyWith<CreateSectionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSectionRequestCopyWith<$Res> {
  factory $CreateSectionRequestCopyWith(CreateSectionRequest value,
          $Res Function(CreateSectionRequest) then) =
      _$CreateSectionRequestCopyWithImpl<$Res, CreateSectionRequest>;
  @useResult
  $Res call({String name, String? levelId, String? departmentId});
}

/// @nodoc
class _$CreateSectionRequestCopyWithImpl<$Res,
        $Val extends CreateSectionRequest>
    implements $CreateSectionRequestCopyWith<$Res> {
  _$CreateSectionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? levelId = freezed,
    Object? departmentId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSectionRequestImplCopyWith<$Res>
    implements $CreateSectionRequestCopyWith<$Res> {
  factory _$$CreateSectionRequestImplCopyWith(_$CreateSectionRequestImpl value,
          $Res Function(_$CreateSectionRequestImpl) then) =
      __$$CreateSectionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? levelId, String? departmentId});
}

/// @nodoc
class __$$CreateSectionRequestImplCopyWithImpl<$Res>
    extends _$CreateSectionRequestCopyWithImpl<$Res, _$CreateSectionRequestImpl>
    implements _$$CreateSectionRequestImplCopyWith<$Res> {
  __$$CreateSectionRequestImplCopyWithImpl(_$CreateSectionRequestImpl _value,
      $Res Function(_$CreateSectionRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? levelId = freezed,
    Object? departmentId = freezed,
  }) {
    return _then(_$CreateSectionRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSectionRequestImpl implements _CreateSectionRequest {
  const _$CreateSectionRequestImpl(
      {required this.name, this.levelId, this.departmentId});

  factory _$CreateSectionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSectionRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String? levelId;
  @override
  final String? departmentId;

  @override
  String toString() {
    return 'CreateSectionRequest(name: $name, levelId: $levelId, departmentId: $departmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSectionRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, levelId, departmentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSectionRequestImplCopyWith<_$CreateSectionRequestImpl>
      get copyWith =>
          __$$CreateSectionRequestImplCopyWithImpl<_$CreateSectionRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSectionRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateSectionRequest implements CreateSectionRequest {
  const factory _CreateSectionRequest(
      {required final String name,
      final String? levelId,
      final String? departmentId}) = _$CreateSectionRequestImpl;

  factory _CreateSectionRequest.fromJson(Map<String, dynamic> json) =
      _$CreateSectionRequestImpl.fromJson;

  @override
  String get name;
  @override
  String? get levelId;
  @override
  String? get departmentId;
  @override
  @JsonKey(ignore: true)
  _$$CreateSectionRequestImplCopyWith<_$CreateSectionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get sectionId => throw _privateConstructorUsedError;
  String? get sectionName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get sessionsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      String? sectionId,
      String? sectionName,
      DateTime? createdAt,
      int? sessionsCount});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? sectionId = freezed,
    Object? sectionName = freezed,
    Object? createdAt = freezed,
    Object? sessionsCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sessionsCount: freezed == sessionsCount
          ? _value.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      String? sectionId,
      String? sectionName,
      DateTime? createdAt,
      int? sessionsCount});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? sectionId = freezed,
    Object? sectionName = freezed,
    Object? createdAt = freezed,
    Object? sessionsCount = freezed,
  }) {
    return _then(_$CourseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _value.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sessionsCount: freezed == sessionsCount
          ? _value.sessionsCount
          : sessionsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  const _$CourseImpl(
      {required this.id,
      required this.name,
      this.code,
      this.sectionId,
      this.sectionName,
      this.createdAt,
      this.sessionsCount});

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? code;
  @override
  final String? sectionId;
  @override
  final String? sectionName;
  @override
  final DateTime? createdAt;
  @override
  final int? sessionsCount;

  @override
  String toString() {
    return 'Course(id: $id, name: $name, code: $code, sectionId: $sectionId, sectionName: $sectionName, createdAt: $createdAt, sessionsCount: $sessionsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sessionsCount, sessionsCount) ||
                other.sessionsCount == sessionsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, code, sectionId,
      sectionName, createdAt, sessionsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {required final String id,
      required final String name,
      final String? code,
      final String? sectionId,
      final String? sectionName,
      final DateTime? createdAt,
      final int? sessionsCount}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get code;
  @override
  String? get sectionId;
  @override
  String? get sectionName;
  @override
  DateTime? get createdAt;
  @override
  int? get sessionsCount;
  @override
  @JsonKey(ignore: true)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateCourseRequest _$CreateCourseRequestFromJson(Map<String, dynamic> json) {
  return _CreateCourseRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCourseRequest {
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get sectionId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateCourseRequestCopyWith<CreateCourseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCourseRequestCopyWith<$Res> {
  factory $CreateCourseRequestCopyWith(
          CreateCourseRequest value, $Res Function(CreateCourseRequest) then) =
      _$CreateCourseRequestCopyWithImpl<$Res, CreateCourseRequest>;
  @useResult
  $Res call({String name, String? code, String? sectionId});
}

/// @nodoc
class _$CreateCourseRequestCopyWithImpl<$Res, $Val extends CreateCourseRequest>
    implements $CreateCourseRequestCopyWith<$Res> {
  _$CreateCourseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
    Object? sectionId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateCourseRequestImplCopyWith<$Res>
    implements $CreateCourseRequestCopyWith<$Res> {
  factory _$$CreateCourseRequestImplCopyWith(_$CreateCourseRequestImpl value,
          $Res Function(_$CreateCourseRequestImpl) then) =
      __$$CreateCourseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? code, String? sectionId});
}

/// @nodoc
class __$$CreateCourseRequestImplCopyWithImpl<$Res>
    extends _$CreateCourseRequestCopyWithImpl<$Res, _$CreateCourseRequestImpl>
    implements _$$CreateCourseRequestImplCopyWith<$Res> {
  __$$CreateCourseRequestImplCopyWithImpl(_$CreateCourseRequestImpl _value,
      $Res Function(_$CreateCourseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = freezed,
    Object? sectionId = freezed,
  }) {
    return _then(_$CreateCourseRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _value.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCourseRequestImpl implements _CreateCourseRequest {
  const _$CreateCourseRequestImpl(
      {required this.name, this.code, this.sectionId});

  factory _$CreateCourseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCourseRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String? code;
  @override
  final String? sectionId;

  @override
  String toString() {
    return 'CreateCourseRequest(name: $name, code: $code, sectionId: $sectionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCourseRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, sectionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCourseRequestImplCopyWith<_$CreateCourseRequestImpl> get copyWith =>
      __$$CreateCourseRequestImplCopyWithImpl<_$CreateCourseRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCourseRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateCourseRequest implements CreateCourseRequest {
  const factory _CreateCourseRequest(
      {required final String name,
      final String? code,
      final String? sectionId}) = _$CreateCourseRequestImpl;

  factory _CreateCourseRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCourseRequestImpl.fromJson;

  @override
  String get name;
  @override
  String? get code;
  @override
  String? get sectionId;
  @override
  @JsonKey(ignore: true)
  _$$CreateCourseRequestImplCopyWith<_$CreateCourseRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
