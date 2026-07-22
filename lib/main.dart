/// نقطة الدخول الرئيسية للتطبيق — الإصدار المحسن
/// تم إصلاح: ربط themeModeProvider، إزالة hardcoded theme
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/di/providers.dart';
import 'services/storage/storage_service.dart';
import 'services/notification/notification_service.dart';
import 'services/database/local_database.dart';

void main() async {
  // تأكد من تهيئة Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // توجيه الشاشة للأعلى ومنع التدوير
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // إعدادات شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // تهيئة الخدمات
  final storageService = StorageService();
  await storageService.init();

  final notificationService = NotificationService();
  await notificationService.init();

  // تهيئة قاعدة البيانات
  final database = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
        notificationServiceProvider.overrideWithValue(notificationService),
        databaseProvider.overrideWithValue(database),
      ],
      child: const AttendanceAdminApp(),
    ),
  );
}

/// التطبيق الرئيسي — يستخدم Riverpod لربط ThemeMode
class AttendanceAdminApp extends ConsumerWidget {
  const AttendanceAdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ربط ThemeMode مع provider — تغييرات الثيم تُطبق فوراً
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'نظام الحضور الذكي',
      
      // تكوين Go Router
      routerConfig: AppRouter.createRouter(),
      
      // تكوين الثيم — يقرأ من provider
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // دعم اللغة العربية (RTL)
      locale: const Locale('ar', 'SA'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],

      // إعدادات التصحيح
      debugShowCheckedModeBanner: false,

      // سلوك التمرير
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
