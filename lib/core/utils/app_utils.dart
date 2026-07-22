/// أدوات مساعدة للتطبيق
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

/// أدوات التاريخ والوقت
class DateUtils {
  DateUtils._();

  /// تنسيق التاريخ
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return intl.DateFormat(pattern).format(date);
  }

  /// تنسيق الوقت
  static String formatTime(DateTime time, {String pattern = 'HH:mm:ss'}) {
    return intl.DateFormat(pattern).format(time);
  }

  /// تنسيق التاريخ والوقت
  static String formatDateTime(DateTime dateTime, {String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    return intl.DateFormat(pattern).format(dateTime);
  }

  /// تنسيق التاريخ بالعربية
  static String formatDateArabic(DateTime date) {
    final formatter = intl.DateFormat('EEEE، d MMMM yyyy', 'ar');
    return formatter.format(date);
  }

  /// الحصول على تاريخ اليوم كنص
  static String get todayDate => formatDate(DateTime.now());

  /// الحصول على الوقت الحالي كنص
  static String get currentTime => formatTime(DateTime.now());

  /// الحصول على بداية اليوم
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// الحصول على نهاية اليوم
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// الحصول على بداية الأسبوع
  static DateTime startOfWeek(DateTime date) {
    final diff = date.weekday - DateTime.monday;
    return startOfDay(date.subtract(Duration(days: diff)));
  }

  /// الحصول على نهاية الأسبوع
  static DateTime endOfWeek(DateTime date) {
    return endOfDay(startOfWeek(date).add(const Duration(days: 6)));
  }

  /// الحصول على بداية الشهر
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// الحصول على نهاية الشهر
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  /// حساب الفرق بين تاريخين بالأيام
  static int daysBetween(DateTime from, DateTime to) {
    from = startOfDay(from);
    to = startOfDay(to);
    return (to.difference(from).inHours / 24).round();
  }

  /// التحقق إذا كان التاريخ هو اليوم
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  /// التحقق إذا كان التاريخ هو الأمس
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }

  /// تحويل الطوابع الزمني إلى DateTime
  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  /// تحويل DateTime إلى طابع زمني
  static int toTimestamp(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).floor();
  }
}

/// أدوات التحقق من صحة البيانات
class ValidationUtils {
  ValidationUtils._();

  /// التحقق من صحة البريد الإلكتروني
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// التحقق من صحة رقم الهاتف
  static bool isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10,15}$').hasMatch(phone.replaceAll(RegExp(r'[\s\-]'), ''));
  }

  /// التحقق من صحة رقم الطالب
  static bool isValidStudentId(String studentId) {
    return RegExp(r'^[a-zA-Z0-9]{4,20}$').hasMatch(studentId);
  }

  /// التحقق من أن النص ليس فارغاً
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// التحقق من طول النص
  static bool hasValidLength(String value, {int min = 2, int max = 100}) {
    final trimmed = value.trim();
    return trimmed.length >= min && trimmed.length <= max;
  }

  /// التحقق من أن القيمة رقم موجب
  static bool isPositiveNumber(dynamic value) {
    if (value is num) {
      return value > 0;
    }
    if (value is String) {
      return num.tryParse(value) != null && num.parse(value) > 0;
    }
    return false;
  }

  /// تنظيف المدخلات من المسافات الزائدة
  static String sanitizeInput(String input) {
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}

/// أدوات التنسيق
class FormatUtils {
  FormatUtils._();

  /// تنسيق الأرقام مع فواصل الآلاف
  static String formatNumber(num number, {int decimalDigits = 0}) {
    if (decimalDigits == 0) {
      final formatter = intl.NumberFormat('#,###');
      return formatter.format(number);
    } else {
      final pattern = '#,##${'.' + '0' * decimalDigits}';
      final formatter = intl.NumberFormat(pattern);
      return formatter.format(number);
    }
  }

  /// تنسيق النسبة المئوية
  static String formatPercentage(double value, {int decimalDigits = 1}) {
    return '${value.toStringAsFixed(decimalDigits)}%';
  }

  /// تنسيق حجم الملف
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  /// تقصير النص مع إضافة ...
  static String truncateText(String text, {int maxLength = 50}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// تحويل النص إلى أحرف كبيرة
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// تحويل حالة الحضور إلى نص عربي
  static String statusToArabic(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return 'حاضر';
      case 'absent':
        return 'غائب';
      case 'late':
        return 'متأخر';
      case 'excused':
        return 'معذور';
      default:
        return status;
    }
  }

  /// تحويل حالة الجلسة إلى نص عربي
  static String sessionStatusToArabic(String status) {
    switch (status.toLowerCase()) {
      case 'created':
        return 'تم الإنشاء';
      case 'active':
        return 'نشطة';
      case 'paused':
        return 'متوقفة مؤقتاً';
      case 'closed':
        return 'مغلقة';
      default:
        return status;
    }
  }
}

/// أدوات الـ UI
class UiUtils {
  UiUtils._();

  /// إخفاء لوحة المفاتيح
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// فتح Drawer إذا كان مغلقًا
  static void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  /// فتح EndDrawer إذا كان مغلقًا
  static void openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  /// عرض Snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: duration,
          action: action,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }

  /// عرض حوار تأكيد
  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: isDestructive ? Theme.of(context).colorScheme.error : null,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// عرض حوار الإدخال
  static Future<String?> showInputDialog(
    BuildContext context, {
    required String title,
    String? hintText,
    String? initialValue,
    String confirmText = 'حفظ',
    String cancelText = 'إلغاء',
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final controller = TextEditingController(text: initialValue);
    
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// عرض Bottom Sheet
  static Future<T?> showBottomSheetModal<T>(BuildContext context, {
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: builder,
    );
  }

  /// الحصول على حجم الشاشة
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// التحقق إذا كان الجهاز لوحي
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide;
    return size >= 600;
  }

  /// التحقق إذا كان الوضع الداكن مفعل
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

/// أدوات التشفير البسيط
class CryptoUtils {
  CryptoUtils._();

  /// إنشاء Hash بسيط باستخدام SHA256
  static String generateHash(String data) {
    // سيتم استخدام crypto package لاحقاً
    return data.hashCode.toRadixString(16);
  }

  /// إنشاء Token عشوائي
  static String generateToken({int length = 32}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(chars[(random + i) % chars.length]);
    }
    return buffer.toString();
  }

  /// إنشاء Device ID فريد
  static String generateDeviceId() {
    return DateTime.now().millisecondsSinceEpoch.toRadixString(16) +
           DateTime.now().microsecond.toRadixString(16);
  }
}
