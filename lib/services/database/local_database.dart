/// قاعدة البيانات الرئيسية باستخدام Drift (SQLite)
library;

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../domain/repositories/repositories.dart';

part 'local_database.g.dart';

// ============================================
// تعريف الجداول
// ============================================

/// جدول الطلاب
class Students extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn get studentId => text().unique()();
  TextColumn? get departmentId => text().nullable()();
  IntColumn? get level => integer().nullable()();
  TextColumn? get sectionId => text().nullable()();
  TextColumn? get phone => text().nullable()();
  TextColumn? get photo => text().nullable()();
  TextColumn? get deviceId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الحضور
class AttendanceRecords extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get sessionId => text()();
  TextColumn get studentId => text()();
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get status =>
      text().withDefault(const Constant('present'))();
  TextColumn? get deviceId => text().nullable()();
  TextColumn? get hash => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  // منع التسجيل المكرر للطالب في نفس الجلسة
  @override
  List<Set<Column>>? get uniqueKeys => [
        {sessionId, studentId},
      ];
}

/// جدول الجلسات
class Sessions extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get courseId => text()();
  TextColumn get sectionId => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn? get endTime => dateTime().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('created'))();
  TextColumn? get ip => text().nullable()();
  IntColumn? get port => integer().nullable()();
  TextColumn? get token => text().nullable()();
  TextColumn? get qrData => text().nullable()();
  TextColumn? get createdById => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الأقسام
class Departments extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn? get code => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول المستويات
class Levels extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get name => text()();
  TextColumn? get code => text().nullable()();
  IntColumn? get order => integer().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الشعب
class Sections extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn? get levelId => text().nullable()();
  TextColumn? get departmentId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول المقررات
class Courses extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get name => text().withLength(min: 2, max: 100)();
  TextColumn? get code => text().nullable()();
  TextColumn? get sectionId => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الإعدادات
class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get type =>
      text().withDefault(const Constant('string'))();
  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

/// جدول السجل
class Logs extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get action => text()();
  TextColumn get entityType => text()();
  TextColumn? get entityId => text().nullable()();
  TextColumn? get details => text().nullable()();
  TextColumn? get userId => text().nullable()();
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول النسخ الاحتياطية
class Backups extends Table {
  TextColumn get id => text().withDefault(const Constant(''))();
  TextColumn get filePath => text()();
  IntColumn get size => integer()();
  IntColumn get recordsCount => integer()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn? get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ============================================
// قاعدة البيانات الرئيسية
// ============================================

@DriftDatabase(tables: [
  Students,
  AttendanceRecords,
  Sessions,
  Departments,
  Levels,
  Sections,
  Courses,
  SettingsTable,
  Logs,
  Backups,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // إضافة بيانات أولية
        await _seedInitialData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // ترقية قاعدة البيانات
        for (var version = from + 1; version <= to; version++) {
          switch (version) {
            case 2:
              // ترقية الإصدار 2
              break;
          }
        }
      },
    );
  }

  /// إضافة بيانات أولية
  Future<void> _seedInitialData() async {
    // إضافة مستويات افتراضية
    await batch((batch) {
      batch.insertAll(levels, [
        LevelsCompanion(
          id: const Value('level_1'),
          name: const Value('المستوى الأول'),
          code: const Value('L1'),
          order: const Value(1),
        ),
        LevelsCompanion(
          id: const Value('level_2'),
          name: const Value('المستوى الثاني'),
          code: const Value('L2'),
          order: const Value(2),
        ),
        LevelsCompanion(
          id: const Value('level_3'),
          name: const Value('المستوى الثالث'),
          code: const Value('L3'),
          order: const Value(3),
        ),
        LevelsCompanion(
          id: const Value('level_4'),
          name: const Value('المستوى الرابع'),
          code: const Value('L4'),
          order: const Value(4),
        ),
      ]);
    });
  }

  // ============================================
  // استعلامات الطلاب
  // ============================================

  /// الحصول على جميع الطلاب
  Future<List<Student>> getAllStudents() {
    return (select(students)..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// البحث عن طالب بالمعرف
  Future<Student?> getStudentById(String id) {
    return (select(students)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// البحث عن طالب برقم الطالب
  Future<Student?> getStudentByStudentId(String studentId) {
    return (select(students)
          ..where((t) => t.studentId.equals(studentId)))
        .getSingleOrNull();
  }

  /// البحث عن طلاب بقسم معين
  Future<List<Student>> getStudentsByDepartment(String departmentId) {
    return (select(students)
          ..where((t) => t.departmentId.equals(departmentId)))
        .get();
  }

  /// البحث عن طلاب بشعبة معينة
  Future<List<Student>> getStudentsBySection(String sectionId) {
    return (select(students)
          ..where((t) => t.sectionId.equals(sectionId)))
        .get();
  }

  /// بحث عن طالب بالاسم أو الرقم
  Future<List<Student>> searchStudents(String query) {
    final pattern = '%$query%';
    return (select(students)
          ..where((t) =>
              t.name.like(pattern) | t.studentId.like(pattern)))
        .get();
  }

  /// الحصول على عدد الطلاب
  Future<int> getStudentsCount() {
    return students.count().getSingle();
  }

  /// إضافة طالب جديد
  Future<int> insertStudent(StudentsCompanion student) {
    return into(students).insert(student);
  }

  /// تحديث بيانات طالب
  Future<bool> updateStudent(Student student) {
    return update(students).replace(student);
  }

  /// حذف طالب
  Future<int> deleteStudent(String id) {
    return (delete(students)..where((t) => t.id.equals(id))).go();
  }

  // ============================================
  // استعلامات الحضور
  // ============================================

  /// الحصول على حضور جلسة معينة
  Future<List<AttendanceRecord>> getSessionAttendance(String sessionId) {
    return (select(attendanceRecords)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }

  /// التحقق من تسجيل حضور الطالب في الجلسة
  Future<bool> isStudentCheckedIn(String sessionId, String studentId) async {
    final query = selectOnly(attendanceRecords)
      ..addColumns([attendanceRecords.id])
      ..where(attendanceRecords.sessionId.equals(sessionId) &
          attendanceRecords.studentId.equals(studentId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// تسجيل حضور جديد
  Future<int> insertAttendanceRecord(AttendanceRecordsCompanion record) {
    return into(attendanceRecords).insert(record);
  }

  /// الحصول على حضور طالب في جميع الجلسات
  Future<List<AttendanceRecord>> getStudentAttendanceHistory(String studentId) {
    return (select(attendanceRecords)
          ..where((t) => t.studentId.equals(studentId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  /// الحصول على إحصائيات الحضور لجلسة
  Future<AttendanceStats> getSessionAttendanceStats(String sessionId) async {
    final records = await getSessionAttendance(sessionId);
    return AttendanceStats(
      totalCount: records.length,
      presentCount: records.where((r) => r.status == 'present').length,
      absentCount: records.where((r) => r.status == 'absent').length,
      lateCount: records.where((r) => r.status == 'late').length,
      excusedCount: records.where((r) => r.status == 'excused').length,
    );
  }

  // ============================================
  // استعلامات الجلسات
  // ============================================

  /// الحصول على جميع الجلسات
  Future<List<Session>> getAllSessions() {
    return (select(sessions)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  /// الحصول على الجلسات النشطة
  Future<List<Session>> getActiveSessions() {
    return (select(sessions)
          ..where((t) => t.status.equals('active'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// الحصول على جلسة بالمعرف
  Future<Session?> getSessionById(String id) {
    return (select(sessions)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// الحصول على جلسة بالتوكن
  Future<Session?> getSessionByToken(String token) {
    return (select(sessions)..where((t) => t.token.equals(token)))
        .getSingleOrNull();
  }

  /// إضافة جلسة جديدة
  Future<int> insertSession(SessionsCompanion session) {
    return into(sessions).insert(session);
  }

  /// تحديث جلسة
  Future<bool> updateSession(Session session) {
    return update(sessions).replace(session);
  }

  // ============================================
  // استعلامات المقررات والشعب والأقسام
  // ============================================

  /// الحصول على جميع المقررات
  Future<List<Course>> getAllCourses() {
    return (select(courses)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// إضافة مقرر جديد
  Future<int> insertCourse(CoursesCompanion course) {
    return into(courses).insert(course);
  }

  /// تحديث مقرر
  Future<bool> updateCourse(Course course) {
    return update(courses).replace(course);
  }

  /// حذف مقرر
  Future<int> deleteCourse(String id) {
    return (delete(courses)..where((t) => t.id.equals(id))).go();
  }

  /// الحصول على جميع الشعب
  Future<List<Section>> getAllSections() {
    return (select(sections)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// إضافة شعبة جديدة
  Future<int> insertSection(SectionsCompanion section) {
    return into(sections).insert(section);
  }

  /// تحديث شعبة
  Future<bool> updateSection(Section section) {
    return update(sections).replace(section);
  }

  /// حذف شعبة
  Future<int> deleteSection(String id) {
    return (delete(sections)..where((t) => t.id.equals(id))).go();
  }

  /// الحصول على جميع الأقسام
  Future<List<Department>> getAllDepartments() {
    return (select(departments)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// إضافة قسم جديد
  Future<int> insertDepartment(DepartmentsCompanion department) {
    return into(departments).insert(department);
  }

  /// تحديث قسم
  Future<bool> updateDepartment(Department department) {
    return update(departments).replace(department);
  }

  /// حذف قسم
  Future<int> deleteDepartment(String id) {
    return (delete(departments)..where((t) => t.id.equals(id))).go();
  }

  // ============================================
  // استعلامات الإعدادات
  // ============================================

  /// الحصول على إعداد
  Future<SettingsTableData?> getSetting(String key) {
    return (select(settingsTable)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
  }

  /// حفظ إعداد
  Future<void> setSetting(String key, String value, {String type = 'string'}) async {
    into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion(
        key: Value(key),
        value: Value(value),
        type: Value(type),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// حذف إعداد
  Future<int> deleteSetting(String key) {
    return (delete(settingsTable)..where((t) => t.key.equals(key))).go();
  }

  // ============================================
  // استعلامات السجل
  // ============================================

  /// إضافة سجل جديد
  Future<int> insertLog(LogsCompanion log) {
    return into(logs).insert(log);
  }

  /// الحصول على السجلات
  Future<List<Log>> getLogs({int limit = 100}) {
    return (select(logs)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .get();
  }

  // ============================================
  // استعلامات النسخ الاحتياطية
  // ============================================

  /// إضافة نسخة احتياطية
  Future<int> insertBackup(BackupsCompanion backup) {
    return into(backups).insert(backup);
  }

  /// الحصول على النسخ الاحتياطية
  Future<List<Backup>> getBackups() {
    return (select(backups)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  // ============================================
  // استعلامات الإحصائيات
  // ============================================

  /// إحصائيات لوحة التحكم
  Future<DashboardStatistics> getDashboardStats() async {
    final totalStudents = await (select(students).get()).then((list) => list.length);
    final activeSessionsList = await (select(sessions)..where((t) => t.status.equals('active'))).get();

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final todayRecords = await (select(attendanceRecords)
      ..where((t) =>
          t.timestamp.isBiggerOrEqualValue(startOfDay) &
          t.timestamp.isSmallerOrEqualValue(endOfDay) &
          (t.status.equals('present') | t.status.equals('late')))
    ).get();

    final totalCourses = await (select(courses).get()).then((list) => list.length);
    final totalSections = await (select(sections).get()).then((list) => list.length);
    final totalDepartments = await (select(departments).get()).then((list) => list.length);

    return DashboardStatistics(
      totalStudents: totalStudents,
      activeSessions: activeSessionsList.length,
      todayAttendance: todayRecords.length,
      totalCourses: totalCourses,
      totalSections: totalSections,
      totalDepartments: totalDepartments,
    );
  }
}

/// فتح اتصال قاعدة البيانات
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'attendance_admin.db'));
    return NativeDatabase.createInBackground(file);
  });
}

/// إحصائيات لوحة التحكم
class DashboardStatistics {
  final int totalStudents;
  final int activeSessions;
  final int todayAttendance;
  final int totalCourses;
  final int totalSections;
  final int totalDepartments;

  DashboardStatistics({
    required this.totalStudents,
    required this.activeSessions,
    required this.todayAttendance,
    required this.totalCourses,
    required this.totalSections,
    required this.totalDepartments,
  });
}
