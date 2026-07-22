/// Dependency Injection باستخدام Riverpod — الإصدار الحقيقي
/// جميع Providers مرتبطة بقاعدة البيانات والخدمات الحقيقية
library;

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/constants/app_constants.dart';
import '../../services/database/local_database.dart';
import '../../services/storage/storage_service.dart';
import '../../services/encryption/encryption_service.dart';
import '../../services/notification/notification_service.dart';
import '../../services/network/http_server_service.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/use_cases/use_cases.dart';

// ============================================
// Providers الأساسية (الخدمات)
// ============================================

/// Provider لقاعدة البيانات
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database must be initialized in main.dart');
});

/// Provider لخدمة التخزين المحلي
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('StorageService must be initialized in main.dart');
});

/// Provider لخدمة التشفير
final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionService();
});

/// Provider لخدمة الإشعارات
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError('NotificationService must be initialized in main.dart');
});

/// Provider لخدمة الخادم HTTP
final httpServerServiceProvider = StateProvider<HttpServerService?>((ref) => null);

// ============================================
// Providers للمستودعات (Repositories)
// ============================================

/// Provider لمستودع الطلاب
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return StudentRepositoryImpl(database);
});

/// Provider لمستودع الحضور
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return AttendanceRepositoryImpl(database);
});

/// Provider لمستودع الجلسات
final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return SessionRepositoryImpl(database);
});

/// Provider لمستودع الإعدادات
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final storageService = ref.watch(storageServiceProvider);
  return SettingsRepositoryImpl(database, storageService);
});

// ============================================
// Providers لحالات الاستخدام (Use Cases)
// ============================================

/// Provider لحالة استخدام الحصول على الطلاب
final getStudentsUseCaseProvider = Provider<GetStudentsUseCase>((ref) {
  return GetStudentsUseCase(ref.watch(studentRepositoryProvider));
});

/// Provider لحالة استخدام إضافة طالب
final addStudentUseCaseProvider = Provider<AddStudentUseCase>((ref) {
  return AddStudentUseCase(ref.watch(studentRepositoryProvider));
});

/// Provider لحالة استخدام تحديث طالب
final updateStudentUseCaseProvider = Provider<UpdateStudentUseCase>((ref) {
  return UpdateStudentUseCase(ref.watch(studentRepositoryProvider));
});

/// Provider لحالة استخدام حذف طالب
final deleteStudentUseCaseProvider = Provider<DeleteStudentUseCase>((ref) {
  return DeleteStudentUseCase(ref.watch(studentRepositoryProvider));
});

/// Provider لحالة استخدام تسجيل حضور
final checkInUseCaseProvider = Provider<CheckInUseCase>((ref) {
  return CheckInUseCase(
    ref.watch(attendanceRepositoryProvider),
    ref.watch(sessionRepositoryProvider),
  );
});

/// Provider لحالة استخدام إحصائيات جلسة
final getSessionStatsUseCaseProvider = Provider<GetSessionStatsUseCase>((ref) {
  return GetSessionStatsUseCase(ref.watch(attendanceRepositoryProvider));
});

/// Provider لحالة استخدام إنشاء جلسة
final createSessionUseCaseProvider = Provider<CreateSessionUseCase>((ref) {
  return CreateSessionUseCase(ref.watch(sessionRepositoryProvider));
});

/// Provider لحالة استخدام إغلاق جلسة
final closeSessionUseCaseProvider = Provider<CloseSessionUseCase>((ref) {
  return CloseSessionUseCase(ref.watch(sessionRepositoryProvider));
});

/// Provider لحالة استخدام الجلسة النشطة
final getActiveSessionUseCaseProvider = Provider<GetActiveSessionUseCase>((ref) {
  return GetActiveSessionUseCase(ref.watch(sessionRepositoryProvider));
});

// ============================================
// Providers للبيانات الحقيقية (Data Providers)
// ============================================

/// Provider لقائمة الطلاب (حقيقي من قاعدة البيانات)
final studentListProvider = FutureProvider<List<StudentEntity>>((ref) async {
  final useCase = ref.watch(getStudentsUseCaseProvider);
  return useCase();
});

/// Provider لعدد الطلاب
final studentCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(studentRepositoryProvider);
  return repo.getStudentsCount();
});

/// Provider لقائمة الجلسات (حقيقي من قاعدة البيانات)
final sessionListProvider = FutureProvider<List<SessionEntity>>((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getAllSessions();
});

/// Provider للجلسات النشطة
final activeSessionListProvider = FutureProvider<List<SessionEntity>>((ref) async {
  final useCase = ref.watch(getActiveSessionUseCaseProvider);
  return useCase();
});

/// Provider لقائمة المقررات (حقيقي من قاعدة البيانات)
final courseListProvider = FutureProvider<List<Course>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getAllCourses();
});

/// Provider لقائمة الشعب
final sectionListProvider = FutureProvider<List<Section>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getAllSections();
});

/// Provider لقائمة الأقسام
final departmentListProvider = FutureProvider<List<Department>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getAllDepartments();
});

/// Provider لإحصائيات لوحة التحكم (حقيقي من قاعدة البيانات)
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final database = ref.watch(databaseProvider);
  final stats = await database.getDashboardStats();
  return DashboardStats(
    totalStudents: stats.totalStudents,
    activeSessions: stats.activeSessions,
    todayAttendance: stats.todayAttendance,
    todayAbsence: 0, // سيتم حسابه لاحقاً
    totalCourses: stats.totalCourses,
    totalSections: stats.totalSections,
  );
});

/// Provider لحضور جلسة معينة
final sessionAttendanceProvider = FutureProvider.family<List<AttendanceEntity>, String>((ref, sessionId) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getSessionAttendance(sessionId);
});

/// Provider لإحصائيات حضور جلسة
final sessionAttendanceStatsProvider = FutureProvider.family<AttendanceStats, String>((ref, sessionId) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getSessionAttendanceStats(sessionId);
});

/// Provider لتفاصيل جلسة
final sessionDetailProvider = FutureProvider.family<SessionEntity?, String>((ref, sessionId) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getSessionById(sessionId);
});

// ============================================
// Providers للـ Theme
// ============================================

/// Provider للوضع الداكن/الفاتح (يقرأ ويكتب في StorageService)
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return ThemeModeNotifier(storageService);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StorageService _storageService;

  ThemeModeNotifier(this._storageService) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final isDark = _storageService.getIsDarkMode();
    if (isDark == true) {
      state = ThemeMode.dark;
    } else if (isDark == false) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    _storageService.setIsDarkMode(mode == ThemeMode.dark);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      // إذا كان system، نتحقق من الوضع الفعلي
      setThemeMode(ThemeMode.dark);
    }
  }
}

/// Provider لحالة الـ RTL
final isRtlProvider = Provider<bool>((ref) => true);

// ============================================
// Providers للمصادقة
// ============================================

/// Provider لحالة المصادقة (حقيقي)
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final encryptionService = ref.watch(encryptionServiceProvider);
  return AuthNotifier(storageService, encryptionService);
});

/// حالة المصادقة
class AuthState {
  final bool isAuthenticated;
  final bool isFirstLaunch;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isFirstLaunch = true,
    this.error,
  });

  AuthState copyWith({bool? isAuthenticated, bool? isFirstLaunch, String? error}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final StorageService _storageService;
  final EncryptionService _encryptionService;

  AuthNotifier(this._storageService, this._encryptionService)
      : super(const AuthState()) {
    _checkAuthState();
  }

  void _checkAuthState() {
    final isFirstLaunch = _storageService.isFirstLaunch();
    final passwordHash = _storageService.getPasswordHash();

    if (isFirstLaunch || passwordHash == null) {
      state = state.copyWith(isFirstLaunch: true, isAuthenticated: false);
    } else {
      // إذا كانت كلمة المرور محفوظة، نعتبر أن المستخدم يحتاج لتسجيل الدخول
      state = state.copyWith(isFirstLaunch: false, isAuthenticated: false);
    }
  }

  /// إعداد كلمة المرور الأولى
  Future<bool> setupPassword(String password) async {
    try {
      final hash = _encryptionService.hashPassword(password);
      await _storageService.setPasswordHash(hash);
      await _storageService.setFirstLaunchCompleted();
      state = state.copyWith(isAuthenticated: true, isFirstLaunch: false);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// تسجيل الدخول
  Future<bool> login(String password) async {
    try {
      final storedHash = _storageService.getPasswordHash();
      if (storedHash == null) {
        state = state.copyWith(error: 'لم يتم إعداد كلمة المرور');
        return false;
      }

      final isValid = _encryptionService.verifyPassword(password, storedHash);
      if (isValid) {
        state = state.copyWith(isAuthenticated: true);
        return true;
      } else {
        state = state.copyWith(error: 'كلمة المرور غير صحيحة');
        return false;
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// تسجيل الخروج
  void logout() {
    state = state.copyWith(isAuthenticated: false);
  }

  /// تغيير كلمة المرور
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final storedHash = _storageService.getPasswordHash();
    if (storedHash == null) return false;

    final isValid = _encryptionService.verifyPassword(oldPassword, storedHash);
    if (!isValid) return false;

    final newHash = _encryptionService.hashPassword(newPassword);
    await _storageService.setPasswordHash(newHash);
    return true;
  }
}

// ============================================
// Providers للجلسات النشطة
// ============================================

/// Provider للجلسة النشطة حالياً
final activeSessionProvider = StateNotifierProvider<ActiveSessionNotifier, ActiveSessionData?>((ref) {
  final database = ref.watch(databaseProvider);
  final encryptionService = ref.watch(encryptionServiceProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  return ActiveSessionNotifier(database, encryptionService, notificationService, storageService, ref);
});

/// حالة الخادم
enum ServerStatus { stopped, starting, running, stopping }

/// Provider لحالة الخادم
final serverStatusProvider = StateProvider<ServerStatus>((ref) => ServerStatus.stopped);

class ActiveSessionNotifier extends StateNotifier<ActiveSessionData?> {
  final AppDatabase _database;
  final EncryptionService _encryptionService;
  final NotificationService _notificationService;
  final StorageService _storageService;
  final Ref _ref;

  HttpServerService? _httpServer;

  ActiveSessionNotifier(
    this._database,
    this._encryptionService,
    this._notificationService,
    this._storageService,
    this._ref,
  ) : super(null) {
    _checkForActiveSession();
  }

  /// التحقق من وجود جلسة نشطة عند بدء التطبيق
  Future<void> _checkForActiveSession() async {
    try {
      final activeSessions = await _database.getActiveSessions();
      if (activeSessions.isNotEmpty) {
        final session = activeSessions.first;
        final ip = await _getLocalIp();
        state = ActiveSessionData(
          id: session.id,
          courseId: session.courseId,
          sectionId: session.sectionId,
          date: session.date,
          startTime: session.startTime,
          ip: ip,
          port: session.port ?? AppConstants.defaultServerPort,
          token: session.token ?? '',
          qrData: session.qrData ?? '',
          connectedCount: 0,
        );
      }
    } catch (_) {
      // لا جلسة نشطة
    }
  }

  /// إنشاء وبدء جلسة حقيقية
  Future<ActiveSessionData> createAndStartSession({
    required String courseId,
    required String sectionId,
    int? customPort,
  }) async {
    final now = DateTime.now();
    final sessionId = '${now.millisecondsSinceEpoch}';
    final port = customPort ?? _storageService.getServerPort() ?? 8080;
    final ip = await _getLocalIp();

    // توليد token حقيقي
    final token = _encryptionService.generateSessionToken(
      courseId: courseId,
      sectionId: sectionId,
      date: now,
    );

    // توليد QR data حقيقي
    final qrData = _encryptionService.generateQrData(
      sessionToken: token,
      ip: ip,
      port: port,
    );

    // إدخال الجلسة في قاعدة البيانات
    final session = SessionEntity(
      id: sessionId,
      courseId: courseId,
      sectionId: sectionId,
      date: now,
      startTime: now,
      status: 'active',
      ip: ip,
      port: port,
      token: token,
      qrData: qrData,
      createdAt: now,
    );

    await _ref.read(sessionRepositoryProvider).createSession(session);

    // بدء HTTP Server
    _httpServer = HttpServerService(encryptionService: _encryptionService);
    await _httpServer!.start(port: port, sessionToken: token, sessionId: sessionId);

    // ربط callbacks للخادم
    _httpServer!.onCheckIn = _handleCheckIn;
    _httpServer!.onVerifyStudent = _handleVerifyStudent;

    // تحديث provider الخادم
    _ref.read(httpServerServiceProvider.notifier).state = _httpServer;
    _ref.read(serverStatusProvider.notifier).state = ServerStatus.running;

    // إرسال إشعار
    await _notificationService.showSessionStarted(courseName: courseId);

    // تحديث الحالة
    final data = ActiveSessionData(
      id: sessionId,
      courseId: courseId,
      sectionId: sectionId,
      date: now,
      startTime: now,
      ip: ip,
      port: port,
      token: token,
      qrData: qrData,
    );
    state = data;
    return data;
  }

  /// معالجة تسجيل حضور حقيقية
  Future<String> _handleCheckIn(CheckInRequest request) async {
    try {
      // التحقق من أن الطالب موجود
      final student = await _database.getStudentByStudentId(request.studentId);
      if (student == null) {
        return jsonEncode({
          'success': false,
          'error': 'الطالب غير موجود في النظام',
        });
      }

      // التحقق من عدم تسجيل الحضور مسبقاً
      final alreadyCheckedIn = await _database.isStudentCheckedIn(
        request.sessionToken.isNotEmpty ? request.sessionToken : (_httpServer?.currentSessionId ?? ''),
        request.studentId,
      );
      if (alreadyCheckedIn) {
        return jsonEncode({
          'success': false,
          'error': 'تم تسجيل الحضور مسبقاً',
          'status': 'duplicate',
        });
      }

      // تسجيل الحضور في قاعدة البيانات
      final attendanceId = '${DateTime.now().millisecondsSinceEpoch}_${request.studentId}';
      final companion = AttendanceRecordsCompanion(
        id: drift.Value(attendanceId),
        sessionId: drift.Value(_httpServer?.currentSessionId ?? state!.id),
        studentId: drift.Value(request.studentId),
        timestamp: drift.Value(DateTime.now()),
        status: drift.Value('present'),
        deviceId: drift.Value(request.deviceId),
        hash: drift.Value(request.hash),
      );
      await _database.insertAttendanceRecord(companion);

      // إرسال إشعار
      await _notificationService.showCheckIn(
        studentName: student.name,
        courseName: state!.courseId,
      );

      // تحديث connectedCount
      state = state?.copyWith(connectedCount: (state?.connectedCount ?? 0) + 1);

      return jsonEncode({
        'success': true,
        'message': 'تم تسجيل الحضور بنجاح',
        'student_name': student.name,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      return jsonEncode({
        'success': false,
        'error': e.toString(),
      });
    }
  }

  /// التحقق من الطالب
  Future<bool> _handleVerifyStudent(String studentId) async {
    final student = await _database.getStudentByStudentId(studentId);
    return student != null;
  }

  /// إغلاق الجلسة
  Future<void> closeSession() async {
    if (state == null) return;

    // إغلاق HTTP Server
    if (_httpServer != null) {
      await _httpServer!.stop();
      _httpServer!.dispose();
      _httpServer = null;
    }

    // تحديث provider الخادم
    _ref.read(httpServerServiceProvider.notifier).state = null;
    _ref.read(serverStatusProvider.notifier).state = ServerStatus.stopped;

    // تحديث الجلسة في قاعدة البيانات
    await _ref.read(sessionRepositoryProvider).closeSession(state!.id);

    // إرسال إشعار
    await _notificationService.showSessionClosed(
      courseName: state!.courseId,
      attendanceCount: state!.connectedCount,
    );

    // إعادة تحديث البيانات
    _ref.invalidate(sessionListProvider);
    _ref.invalidate(dashboardStatsProvider);
    _ref.invalidate(activeSessionListProvider);

    state = null;
  }

  /// الحصول على IP المحلي
  Future<String> _getLocalIp() async {
    try {
      for (var interface in await NetworkInterface.list(type: InternetAddressType.IPv4)) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (_) {}
    return '127.0.0.1';
  }

  @override
  void dispose() {
    _httpServer?.dispose();
    super.dispose();
  }
}

// ============================================
// Models
// ============================================

/// بيانات الجلسة النشطة
class ActiveSessionData {
  final String id;
  final String courseId;
  final String sectionId;
  final DateTime date;
  final DateTime startTime;
  final String ip;
  final int port;
  final String token;
  final String qrData;
  final int connectedCount;

  ActiveSessionData({
    required this.id,
    required this.courseId,
    required this.sectionId,
    required this.date,
    required this.startTime,
    required this.ip,
    required this.port,
    required this.token,
    required this.qrData,
    this.connectedCount = 0,
  });

  ActiveSessionData copyWith({
    String? id,
    String? courseId,
    String? sectionId,
    DateTime? date,
    DateTime? startTime,
    String? ip,
    int? port,
    String? token,
    String? qrData,
    int? connectedCount,
  }) {
    return ActiveSessionData(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      sectionId: sectionId ?? this.sectionId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      token: token ?? this.token,
      qrData: qrData ?? this.qrData,
      connectedCount: connectedCount ?? this.connectedCount,
    );
  }
}

/// بيانات إحصائيات لوحة التحكم
class DashboardStats {
  final int totalStudents;
  final int activeSessions;
  final int todayAttendance;
  final int todayAbsence;
  final int totalCourses;
  final int totalSections;

  DashboardStats({
    required this.totalStudents,
    required this.activeSessions,
    required this.todayAttendance,
    required this.todayAbsence,
    required this.totalCourses,
    required this.totalSections,
  });
}
