/// امتدادات Dart مساعدة
library;

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// امتداد لـ String
extension StringExtension on String {
  /// التحقق مما إذا كان النص بريداً إلكترونياً
  bool get isEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  /// التحقق مما إذا كان النص رقم هاتف
  bool get isPhone => RegExp(r'^[0-9]{10,15}$').hasMatch(this.replaceAll(RegExp(r'[\s\-]'), ''));

  /// التحقق مما إذا كان النص رقم فقط
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// التحقق مما إذا كان النص يحتوي على أحرف فقط
  bool get isAlphaOnly => RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(this);

  /// التحقق مما إذا كان النص فارغاً أو مسافات فقط
  bool get isBlank => trim().isEmpty;

  /// التحقق مما إذا كان النص ليس فارغاً
  bool get isNotBlank => trim().isNotEmpty;

  /// أول حرف كبير
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// كل الكلمات تبدأ بحرف كبير
  String get capitalizeAll => split(' ').map((word) => word.capitalize).join(' ');

  /// تقصير النص
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength) + suffix;
  }

  /// إزالة المسافات الزائدة
  String get sanitize => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// التحقق مما إذا كان النص URL صالح
  bool get isUrl => tryParseUrl != null;

  Uri? get tryParseUrl => Uri.tryParse(this);
}

/// امتداد لـ int
extension IntExtension on int {
  /// تنسيق مع فواصل الآلاف
  String get formatted {
    if (this < 1000) return toString();
    if (this < 1000000) {
      final thousands = (this / 1000).toStringAsFixed(1);
      return '$thousands K';
    }
    final millions = (this / 1000000).toStringAsFixed(1);
    return '$millions M';
  }

  /// تحويل إلى حجم ملف
  String get fileSize {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) {
      return '${(this / 1024).toStringAsFixed(1)} KB';
    }
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// تحويل ثواني إلى نص قابل للقراءة
  String get readableDuration {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    final seconds = this % 60;
    
    if (hours > 0) {
      return '${hours}س ${minutes}د';
    } else if (minutes > 0) {
      return '${minutes}د ${seconds}ث';
    } else {
      return '$secondsث';
    }
  }
}

/// امتداد لـ double
extension DoubleExtension on double {
  /// تقريب لعدد محدد من الخانات العشرية
  double roundToPrecision(int fractionDigits) {
    final factor = math.pow(10, fractionDigits).toDouble();
    return (this * factor).round() / factor;
  }

  /// تحويل إلى نسبة مئوية
  String get percentage => '${toStringAsFixed(1)}%';

  /// التحقق مما إذا كان الرقم بين قيمتين
  bool isBetween(double min, double max) => this >= min && this <= max;
}

/// امتداد لـ DateTime
extension DateTimeExtension on DateTime {
  /// هل هذا التاريخ هو اليوم؟
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// هل هذا التاريخ هو الأمس؟
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// هل هذا التاريخ هو الغد؟
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  /// بداية اليوم
  DateTime get startOfDay => DateTime(year, month, day);

  /// نهاية اليوم
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// بداية الأسبوع
  DateTime get startOfWeek {
    final diff = weekday - DateTime.monday;
    return subtract(Duration(days: diff)).startOfDay;
  }

  /// نهاية الأسبوع
  DateTime get endOfWeek => startOfDay.add(const Duration(days: 6)).endOfDay;

  /// بداية الشهر
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// نهاية الشهر
  DateTime get endOfMonth {
    if (month == 12) {
      return DateTime(year + 1, 1, 0, 23, 59, 59, 999);
    }
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// الفرق عن الآن بالأيام
  int get daysFromNow {
    final now = DateTime.now();
    return difference(now).inDays;
  }

  /// نسخة قابلة للمقارنة (بدون وقت)
  DateTime get dateOnly => DateTime(year, month, day);

  /// تنسيق التاريخ باستخدام intl
  String format([String pattern = 'yyyy-MM-dd']) {
    try {
      // استخدام DateFormat من intl package
      // هذا يتطلب استيراد intl
      return toString(); // بديل مؤقت - يفضل استخدام DateUtils.formatDate
    } catch (e) {
      return toIso8601String().split('T').first;
    }
  }
}

/// امتداد لـ List
extension ListExtension<T> on List<T> {
  /// هل القائمة فارغة؟
  bool get isNotNullOrEmpty => isNotEmpty;

  /// هل القائمة فارغة أو null؟
  bool get isNullOrEmpty => isEmpty;

  /// الحصول على عنصر بأمان (مع index bounds check)
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// تقسيم القائمة إلى مجموعات
  List<List<T>> chunked(int chunkSize) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, (i + chunkSize).clamp(0, length)));
    }
    return chunks;
  }

  /// هل تحتوي القائمة على أي عنصر يحقق الشرط؟
  bool anyOrNull(bool Function(T element)? test) {
    if (test == null) return isNotEmpty;
    return any(test);
  }
}

/// امتداد لـ BuildContext
extension BuildContextExtension on BuildContext {
  /// الحصول على Theme
  ThemeData get theme => Theme.of(this);

  /// الحصول على ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// الحصول على TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// الحصول على Size
  Size get screenSize => MediaQuery.of(this).size;

  /// الحصول على العرض
  double get screenWidth => MediaQuery.of(this).size.width;

  /// الحصول على الارتفاع
  double get screenHeight => MediaQuery.of(this).size.height;

  /// التحقق من الوضع الداكن
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// التحقق ما إذا كان الجهاز لوحي
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;

  /// التحقق ما إذا كان الجهاز هاتف
  bool get isPhone => !isTablet;

  /// إخفاء لوحة المفاتيح
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// عرض Snackbar
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          action: action,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
  }

  /// الانتقال لصفحة جديدة
  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// استبدال الصفحة الحالية
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.pushReplacement<T, dynamic>(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// العودة للصفحة السابقة
  void pop<T>([T? result]) => Navigator.pop(this, result);
}
