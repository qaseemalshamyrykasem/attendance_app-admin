/// خدمة الإشعارات المحلية
library;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// تهيئة خدمة الإشعارات
  Future<void> init() async {
    // تهيئة timezone
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // طلب الإذن على Android 13+
    await _requestPermissions();
  }

  /// طلب أذونات الإشعارات
  Future<void> _requestPermissions() async {
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
  }

  /// معالجة النقر على الإشعار
  void _onNotificationTapped(NotificationResponse response) {
    // يمكن التعامل مع النقر هنا
    print('Notification tapped: ${response.payload}');
  }

  // ============================================
  // عرض الإشعارات الفورية
  // ============================================

  /// إشعار بسيط
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'attendance_channel',
        'إشعارات الحضور',
        channelDescription: 'إشعارات متعلقة بنظام الحضور',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  /// إشعار ببدء جلسة جديدة
  Future<void> showSessionStartedNotification({
    required String courseName,
    required String sectionName,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: '🎓 بدأت جلسة جديدة',
      body: '$courseName - $sectionName',
      payload: 'session_started',
    );
  }

  /// إشعار بتسجيل حضور جديد
  Future<void> showCheckInNotification({
    required String studentName,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1,
      title: '✅ تسجيل حضور',
      body: 'تم تسجيل حضور: $studentName',
      payload: 'check_in',
    );
  }

  /// إشعار بإغلاق جلسة
  Future<void> showSessionClosedNotification({
    required String courseName,
    int attendanceCount = 0,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 2,
      title: '🔒 تم إغلاق الجلسة',
      body: '$courseName - عدد الحاضرين: $attendanceCount',
      payload: 'session_closed',
    );
  }

  /// إشعار بإنجاز النسخ الاحتياطي
  Future<void> showBackupCompleteNotification({
    required int recordsCount,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3,
      title: '💾 اكتمل النسخ الاحتياطي',
      body: 'تم نسخ $recordsCount سجل بنجاح',
      payload: 'backup_complete',
    );
  }

  /// إشعار تحذيري
  Future<void> showWarningNotification({
    required String title,
    required String body,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 100,
      title: '⚠️ $title',
      body: body,
      payload: 'warning',
    );
  }

  // ============================================
  // الإشعارات المجدولة
  // ============================================

  /// جدولة إشعار
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'scheduled_channel',
        'إشعارات مجدولة',
        channelDescription: 'إشعارات مجدولة مسبقاً',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// جدولة تذكير بإغلاق الجلسة
  Future<void> scheduleSessionReminder({
    required DateTime sessionEndTime,
    required String courseName,
  }) async {
    // تذكير قبل 5 دقائق
    final reminderTime = sessionEndTime.subtract(const Duration(minutes: 5));

    await scheduleNotification(
      id: reminderTime.millisecondsSinceEpoch ~/ 1000,
      title: '⏰ تذكير بإغلاق الجلسة',
      body: 'ستنتهي جلسة $courseName بعد 5 دقائق',
      scheduledDate: reminderTime,
      payload: 'session_reminder',
    );
  }

  // ============================================
  // إدارة الإشعارات
  // ============================================

  /// إلغاء إشعار محدد
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// إلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// الحصول على قائمة الإشعارات المعروضة
  Future<List<ActiveNotification>> getActiveNotifications() async {
    return await _notifications.getActiveNotifications();
  }

  /// الحصول على قائمة الإشعارات المجدولة
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
