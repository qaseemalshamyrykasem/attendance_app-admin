/// إدارة الثيمات - الوضع الفاتح والداكن
library;

import 'package:flutter/material.dart';
import 'app_colors.dart';

/// الثيم الرئيسي للتطبيق
class AppTheme {
  AppTheme._();

  /// الحصول على الثيم الفاتح
  static ThemeData get lightTheme => _createLightTheme();

  /// الحصول على الثيم الداكن
  static ThemeData get darkTheme => _createDarkTheme();

  /// إنشاء الثيم الفاتح
  static ThemeData _createLightTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColorsLight.primary,
      onPrimary: AppColorsLight.onPrimary,
      primaryContainer: AppColorsLight.primaryContainer,
      onPrimaryContainer: Color(0xFF002105),
      secondary: AppColorsLight.secondary,
      onSecondary: AppColorsLight.onSecondary,
      secondaryContainer: AppColorsLight.secondaryContainer,
      onSecondaryContainer: Color(0xFF003A18),
      tertiary: AppColorsLight.tertiary,
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: AppColorsLight.tertiaryContainer,
      onTertiaryContainer: Color(0xFF002019),
      error: AppColorsLight.error,
      onError: AppColorsLight.onError,
      errorContainer: AppColorsLight.errorContainer,
      onErrorContainer: Color(0xFF410002),
      surface: AppColorsLight.background,
      onSurface: AppColorsLight.onBackground,
      surfaceContainerHighest: Color(0xFFEFEFF4),
      outline: AppColorsLight.outline,
      outlineVariant: AppColorsLight.outlineVariant,
      shadow: AppColorsLight.shadow,
      scrim: AppColorsLight.scrim,
      inverseSurface: AppColorsLight.inverseSurface,
      inverseOnSurface: AppColorsLight.inverseOnSurface,
      inversePrimary: AppColorsLight.inversePrimary,
    );

    return _buildLightTheme(colorScheme);
  }

  /// إنشاء الثيم الداكن
  static ThemeData _createDarkTheme() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColorsDark.primary,
      onPrimary: AppColorsDark.onPrimary,
      primaryContainer: AppColorsDark.primaryContainer,
      onPrimaryContainer: Color(0xFFA6F5AD),
      secondary: AppColorsDark.secondary,
      onSecondary: AppColorsDark.onSecondary,
      secondaryContainer: AppColorsDark.secondaryContainer,
      onSecondaryContainer: Color(0xFFA5D6A7),
      tertiary: AppColorsDark.tertiary,
      onTertiary: Color(0xFF003727),
      tertiaryContainer: AppColorsDark.tertiaryContainer,
      onTertiaryContainer: Color(0xFF80CBC4),
      error: AppColorsDark.error,
      onError: AppColorsDark.onError,
      errorContainer: AppColorsDark.errorContainer,
      onErrorContainer: Color(0xFF93000A),
      surface: AppColorsDark.background,
      onSurface: AppColorsDark.onBackground,
      surfaceContainerHighest: Color(0xFF2B2930),
      outline: AppColorsDark.outline,
      outlineVariant: AppColorsDark.outlineVariant,
      shadow: AppColorsDark.shadow,
      scrim: AppColorsDark.scrim,
      inverseSurface: AppColorsDark.inverseSurface,
      inverseOnSurface: AppColorsDark.inverseOnSurface,
      inversePrimary: AppColorsDark.inversePrimary,
    );

    return _buildDarkTheme(colorScheme);
  }

  static ThemeData _buildLightTheme(ColorScheme colorScheme) {
    return _buildTheme(
      colorScheme: colorScheme,
      appBarBg: AppColorsLight.appBarBackground,
      appBarFg: AppColorsLight.appBarForeground,
      cardBg: AppColorsLight.cardBackground,
      cardShadow: AppColorsLight.cardShadow,
      fabBg: AppColorsLight.fabBackground,
      fabFg: AppColorsLight.fabForeground,
      navBar: AppColorsLight.navigationBar,
      navBarSel: AppColorsLight.navigationBarSelected,
      navBarUnsel: AppColorsLight.navigationBarUnselected,
      inputFill: AppColorsLight.inputFill,
      inputBorder: AppColorsLight.inputBorder,
      inputFocused: AppColorsLight.inputFocusedBorder,
      bottomSheet: AppColorsLight.bottomSheet,
      dialogBg: AppColorsLight.dialogBackground,
      snackbarBg: AppColorsLight.snackbarBackground,
      snackbarFg: AppColorsLight.snackbarForeground,
      dividerColor: AppColorsLight.divider,
      containerColor: AppColorsLight.container,
      onContainerColor: AppColorsLight.onContainer,
    );
  }

  static ThemeData _buildDarkTheme(ColorScheme colorScheme) {
    return _buildTheme(
      colorScheme: colorScheme,
      appBarBg: AppColorsDark.appBarBackground,
      appBarFg: AppColorsDark.appBarForeground,
      cardBg: AppColorsDark.cardBackground,
      cardShadow: AppColorsDark.cardShadow,
      fabBg: AppColorsDark.fabBackground,
      fabFg: AppColorsDark.fabForeground,
      navBar: AppColorsDark.navigationBar,
      navBarSel: AppColorsDark.navigationBarSelected,
      navBarUnsel: AppColorsDark.navigationBarUnselected,
      inputFill: AppColorsDark.inputFill,
      inputBorder: AppColorsDark.inputBorder,
      inputFocused: AppColorsDark.inputFocusedBorder,
      bottomSheet: AppColorsDark.bottomSheet,
      dialogBg: AppColorsDark.dialogBackground,
      snackbarBg: AppColorsDark.snackbarBackground,
      snackbarFg: AppColorsDark.snackbarForeground,
      dividerColor: AppColorsDark.divider,
      containerColor: AppColorsDark.container,
      onContainerColor: AppColorsDark.onContainer,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color appBarBg,
    required Color appBarFg,
    required Color cardBg,
    required Color cardShadow,
    required Color fabBg,
    required Color fabFg,
    required Color navBar,
    required Color navBarSel,
    required Color navBarUnsel,
    required Color inputFill,
    required Color inputBorder,
    required Color inputFocused,
    required Color bottomSheet,
    required Color dialogBg,
    required Color snackbarBg,
    required Color snackbarFg,
    required Color dividerColor,
    required Color containerColor,
    required Color onContainerColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      fontFamily: 'Cairo',

      appBarTheme: AppBarTheme(
        backgroundColor: appBarBg,
        foregroundColor: appBarFg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: appBarFg,
        ),
        iconTheme: IconThemeData(color: appBarFg),
      ),

      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 2,
        shadowColor: cardShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: inputBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: inputBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: inputFocused, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colorScheme.error)),
        prefixIconColor: colorScheme.outline,
        suffixIconColor: colorScheme.outline,
        labelStyle: TextStyle(fontFamily: 'Cairo', color: colorScheme.onSurface.withValues(alpha: 0.7)),
        hintStyle: TextStyle(fontFamily: 'Cairo', color: colorScheme.onSurface.withValues(alpha: 0.4)),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: fabBg,
        foregroundColor: fabFg,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: navBar,
        indicatorColor: navBarSel.withValues(alpha: 0.15),
        elevation: 8,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w600, color: navBarSel);
          }
          return TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.w400, color: navBarUnsel);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: navBarSel);
          }
          return IconThemeData(color: navBarUnsel);
        }),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bottomSheet,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
        contentTextStyle: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: colorScheme.onSurface.withValues(alpha: 0.8)),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: snackbarBg,
        contentTextStyle: TextStyle(fontFamily: 'Cairo', color: snackbarFg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      dividerTheme: DividerThemeData(color: dividerColor, thickness: 1),

      chipTheme: ChipThemeData(
        backgroundColor: containerColor,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(fontFamily: 'Cairo', color: onContainerColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary.withValues(alpha: 0.5);
          return colorScheme.outlineVariant;
        }),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primary.withValues(alpha: 0.2),
        circularTrackColor: colorScheme.primary.withValues(alpha: 0.2),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: colorScheme.inverseSurface, borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontFamily: 'Cairo', color: colorScheme.onSurface, fontSize: 12),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.outline,
        indicatorColor: colorScheme.primary,
        labelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w400),
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
