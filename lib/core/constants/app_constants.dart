/// ثوابت التطبيق الأساسية
/// تحتوي على جميع القيم الثابتة المستخدمة في التطبيق
library;

class AppConstants {
  // معلومات التطبيق
  static const String appName = 'نظام الحضور الذكي';
  static const String appSubtitle = 'لوحة التحكم';
  static const String appVersion = '1.0.0';
  static const String appPackage = 'com.attendance.admin';

  // إعدادات الخادم المحلي
  static const int defaultServerPort = 8080;
  static const String defaultServerHost = '0.0.0.0';
  static const int maxConnections = 100;
  static const Duration requestTimeout = Duration(seconds: 30);

  // مفاتيح التخزين المحلي
  static const String keyAuthToken = 'auth_token';
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyIsDarkMode = 'is_dark_mode';
  static const String keyLanguage = 'language';
  static const String keyPasswordHash = 'password_hash';
  static const String keyUseBiometrics = 'use_biometrics';
  static const String keyLastBackupTime = 'last_backup_time';
  static const String keyAutoBackupEnabled = 'auto_backup_enabled';
  static const String keyServerPort = 'server_port';
  static const String keySessionToken = 'session_token';

  // Hive Box Names
  static const String boxSettings = 'settings_box';
  static const String boxCache = 'cache_box';
  static const String boxSession = 'session_box';

  // حالات الحضور
  static const String statusPresent = 'present';
  static const String statusAbsent = 'absent';
  static const String statusLate = 'late';
  static const String statusExcused = 'excused';

  // حالات الجلسة
  static const String sessionCreated = 'created';
  static const String sessionActive = 'active';
  static const String sessionPaused = 'paused';
  static const String sessionClosed = 'closed';

  // أنواع السجل
  static const String logTypeCreate = 'create';
  static const String logTypeUpdate = 'update';
  static const String logTypeDelete = 'delete';
  static const String logTypeLogin = 'login';
  static const String logTypeLogout = 'logout';
  static const String logTypeExport = 'export';
  static const String logTypeImport = 'import';
  static const String logTypeBackup = 'backup';
  static const String logTypeRestore = 'restore';

  // أنواع الكيانات
  static const String entityStudent = 'student';
  static const String entitySession = 'session';
  static const String entityAttendance = 'attendance';
  static const String entityCourse = 'course';
  static const String entitySection = 'section';
  static const String entityDepartment = 'department';
  static const String entitySettings = 'settings';

  // API Endpoints
  static const String apiCheckIn = '/api/attendance/check-in';
  static const String apiSessionInfo = '/api/session/info';
  static const String apiSessionStatus = '/api/session/status';
  static const String apiStudentVerify = '/api/student/verify';
  static const String apiHealthCheck = '/api/health';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Animation Durations
  static const int animationDurationMs = 300;
  static const int splashDurationMs = 2000;

  // Regex Patterns
  static const String phoneRegex = r'^[0-9]{10,15}$';
  static const String studentIdRegex = r'^[a-zA-Z0-9]{4,20}$';

  // File Extensions
  static const String excelExtension = '.xlsx';
  static const String pdfExtension = '.pdf';
  static const String backupExtension = '.backup';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Private constructor - لا يمكن إنشاء نسخة
  AppConstants._();
}

/// رسائل الخطأ القياسية
class ErrorMessages {
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String serverError = 'خطأ في الخادم الداخلي';
  static const String authError = 'غير مصرح لك بالوصول';
  static const String notFound = 'لم يتم العثور على البيانات';
  static const String validationError = 'بيانات غير صحيحة';
  static const String duplicateEntry = 'هذه البيانات موجودة مسبقاً';
  static const String sessionClosed = 'تم إغلاق هذه الجلسة';
  static const String alreadyCheckedIn = 'تم تسجيل الحضور مسبقاً';
  static const String invalidQRCode = 'رمز QR غير صالح';
  static const String studentNotFound = 'الطالب غير موجود';
  static const String generalError = 'حدث خطأ غير متوقع';

  // Private constructor
  ErrorMessages._();
}

/// رسائل النجاح
class SuccessMessages {
  static const String sessionCreated = 'تم إنشاء الجلسة بنجاح';
  static const String sessionClosed = 'تم إغلاق الجلسة بنجاح';
  static const String attendanceRecorded = 'تم تسجيل الحضور بنجاح';
  static const String studentAdded = 'تمت إضافة الطالب بنجاح';
  static const String studentUpdated = 'تم تحديث بيانات الطالب';
  static const String studentDeleted = 'تم حذف الطالب بنجاح';
  static const String dataExported = 'تم تصدير البيانات بنجاح';
  static const String dataImported = 'تم استيراد البيانات بنجاح';
  static const String backupCreated = 'تم إنشاء النسخة الاحتياطية';
  static const String backupRestored = 'تم استعادة النسخة الاحتياطية';
  static const String settingsSaved = 'تم حفظ الإعدادات بنجاح';

  // Private constructor
  SuccessMessages._();
}
