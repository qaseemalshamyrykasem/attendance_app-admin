/// ألوان التطبيق - يدعم الوضع الفاتح والداكن
library;

import 'package:flutter/material.dart';

/// ألوان الوضع الفاتح
class AppColorsLight {
  static const Color primary = Color(0xFF1B5E20);
  static const Color primaryContainer = Color(0xFFE8F5E9);
  static const Color onPrimary = Color(0xFFFFFFFF);
  
  static const Color secondary = Color(0xFF2E7D32);
  static const Color secondaryContainer = Color(0xFFC8E6C9);
  static const Color onSecondary = Color(0xFFFFFFFF);
  
  static const Color tertiary = Color(0xFF00695C);
  static const Color tertiaryContainer = Color(0xFFB2DFDB);
  
  static const Color error = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFCDD2);
  static const Color onError = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color info = Color(0xFF0288D1);
  
  static const Color background = Color(0xFFFFFBFE);
  static const Color surface = Color(0xFFFFFBFE);
  static const Color onBackground = Color(0xFF1C1B1F);
  static const Color onSurface = Color(0xFF1C1B1F);
  
  static const Color outline = Color(0xFF747775);
  static const Color outlineVariant = Color(0xFFCAC4D0);
  
  static const Color container = Color(0xFFF3EDF7);
  static const Color onContainer = Color(0xFF211A21);
  
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  
  static const Color inverseSurface = Color(0xFF313033);
  static const Color inverseOnSurface = Color(0xFFF4EFF4);
  static const Color inversePrimary = Color(0xFF81C784);
  
  // حالة الحضور
  static const Color present = Color(0xFF2E7D32);
  static const Color absent = Color(0xFFD32F2F);
  static const Color late = Color(0xFFED6C02);
  static const Color excused = Color(0xFF0288D1);
  
  // سطح البطاقات
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A000000);
  
  // شريط التنقل
  static const Color navigationBar = Color(0xFFFFFFFF);
  static const Color navigationBarSelected = Color(0xFF1B5E20);
  static const Color navigationBarUnselected = Color(0xFF757575);
  
  // AppBar
  static const Color appBarBackground = Color(0xFF1B5E20);
  static const Color appBarForeground = Color(0xFFFFFFFF);
  
  // Floating Action Button
  static const Color fabBackground = Color(0xFF1B5E20);
  static const Color fabForeground = Color(0xFFFFFFFF);
  
  // Input Fields
  static const Color inputFill = Color(0xFFF5F5F5);
  static const Color inputBorder = Color(0xFFBDBDBD);
  static const Color inputFocusedBorder = Color(0xFF1B5E20);
  
  // Divider
  static const Color divider = Color(0xFFE0E0E0);
  
  // Snackbar
  static const Color snackbarBackground = Color(0xFF323232);
  static const Color snackbarForeground = Color(0xFFFFFFFF);
  
  // Bottom Sheet
  static const Color bottomSheet = Color(0xFFFFFFFF);
  static const Color bottomSheetModalBarrier = Color(0x80000000);
  
  // Dialog
  static const Color dialogBackground = Color(0xFFFFFFFF);
  static const Color dialogOverlay = Color(0x80000000);
}

/// ألوان الوضع الداكن
class AppColorsDark {
  static const Color primary = Color(0xFF81C784);
  static const Color primaryContainer = Color(0xFF1B5E20);
  static const Color onPrimary = Color(0xFF003311);
  
  static const Color secondary = Color(0xFFA5D6A7);
  static const Color secondaryContainer = Color(0xFF2E7D32);
  static const Color onSecondary = Color(0xFF003311);
  
  static const Color tertiary = Color(0xFF80CBC4);
  static const Color tertiaryContainer = Color(0xFF004D40);
  
  static const Color error = Color(0xFFF2B8B5);
  static const Color errorContainer = Color(0xFF601410);
  static const Color onError = Color(0xFF601410);
  
  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF4FC3F7);
  
  static const Color background = Color(0xFF1C1B1F);
  static const Color surface = Color(0xFF1C1B1F);
  static const Color onBackground = Color(0xFFE6E1E5);
  static const Color onSurface = Color(0xFFE6E1E5);
  
  static const Color outline = Color(0xFF938F99);
  static const Color outlineVariant = Color(0xFF49454F);
  
  static const Color container = Color(0xFF2B2930);
  static const Color onContainer = Color(0xFFE6E1E5);
  
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  
  static const Color inverseSurface = Color(0xFFE6E1E5);
  static const Color inverseOnSurface = Color(0xFF313033);
  static const Color inversePrimary = Color(0xFF1B5E20);
  
  // حالة الحضور
  static const Color present = Color(0xFF81C784);
  static const Color absent = Color(0xFFF2B8B5);
  static const Color late = Color(0xFFFFB74D);
  static const Color excused = Color(0xFF4FC3F7);
  
  // سطح البطاقات
  static const Color cardBackground = Color(0xFF2B2930);
  static const Color cardShadow = Color(0x1A000000);
  
  // شريط التنقل
  static const Color navigationBar = Color(0xFF1C1B1F);
  static const Color navigationBarSelected = Color(0xFF81C784);
  static const Color navigationBarUnselected = Color(0xFF938F99);
  
  // AppBar
  static const Color appBarBackground = Color(0xFF1B5E20);
  static const Color appBarForeground = Color(0xFFFFFFFF);
  
  // Floating Action Button
  static const Color fabBackground = Color(0xFF81C784);
  static const Color fabForeground = Color(0xFF003311);
  
  // Input Fields
  static const Color inputFill = Color(0xFF2B2930);
  static const Color inputBorder = Color(0xFF49454F);
  static const Color inputFocusedBorder = Color(0xFF81C784);
  
  // Divider
  static const Color divider = Color(0xFF49454F);
  
  // Snackbar
  static const Color snackbarBackground = Color(0xFF4A444C);
  static const Color snackbarForeground = Color(0xFFE6E1E5);
  
  // Bottom Sheet
  static const Color bottomSheet = Color(0xFF2B2930);
  static const Color bottomSheetModalBarrier = Color(0xB8000000);
  
  // Dialog
  static const Color dialogBackground = Color(0xFF2B2930);
  static const Color dialogOverlay = Color(0xB8000000);
}

/// امتداد للحصول على الألوان حسب الوضع
extension AppColorScheme on ColorScheme {
  bool get isDark => brightness == Brightness.dark;
  
  // ألوان الحالة
  Color get presentColor => isDark ? AppColorsDark.present : AppColorsLight.present;
  Color get absentColor => isDark ? AppColorsDark.absent : AppColorsLight.absent;
  Color get lateColor => isDark ? AppColorsDark.late : AppColorsLight.late;
  Color get excusedColor => isDark ? AppColorsDark.excused : AppColorsLight.excused;
  
  /// الحصول على لون حالة الحضور
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return presentColor;
      case 'absent':
        return absentColor;
      case 'late':
        return lateColor;
      case 'excused':
        return excusedColor;
      default:
        return this.outline;
    }
  }
}
