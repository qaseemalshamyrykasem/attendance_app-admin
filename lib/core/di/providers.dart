/// Dependency Injection باستخدام Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database/local_database.dart';
import '../../services/storage/storage_service.dart';
import '../../services/encryption/encryption_service.dart';
import '../../services/notification/notification_service.dart';
import '../../services/network/http_server_service.dart';

// ============================================
// Providers الأساسية
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
  return NotificationService();
});

/// Provider لخدمة الخادم HTTP
final httpServerServiceProvider = StateProvider<HttpServerService?>((ref) => null);

// ============================================
// Providers للـ Theme
// ============================================

/// Provider للوضع الداكن/الفاتح
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Provider لحالة الـ RTL
final isRtlProvider = Provider<bool>((ref) => true);

// ============================================
// Providers للمصادقة
// ============================================

/// Provider لحالة المصادقة
final authStateProvider = StateProvider<bool>((ref) => false);

/// Provider لمستخدم مسجل حالياً
final currentUserProvider = StateProvider<String?>((ref) => null);

// ============================================
// Providers للجلسات
// ============================================

/// Provider للجلسة النشطة حالياً
final activeSessionProvider = StateProvider<ActiveSessionData?>((ref) => null);

/// Provider لحالة الخادم
final serverStatusProvider = StateProvider<ServerStatus>((ref) {
  return ServerStatus.stopped;
});

/// حالة الخادم
enum ServerStatus { starting, running, stopping, stopped }

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

// ============================================
// Providers للإحصائيات
// ============================================

/// Provider لإحصائيات لوحة التحكم
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  // سيتم تنفيذها لاحقاً
  return DashboardStats(
    totalStudents: 0,
    activeSessions: 0,
    todayAttendance: 0,
    todayAbsence: 0,
    totalCourses: 0,
    totalSections: 0,
  );
});

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
