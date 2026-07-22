/// نقطة الدخول الرئيسية للتطبيق
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
    AttendanceAdminApp(
      storageService: storageService,
      notificationService: notificationService,
      database: database,
    ),
  );
}

/// التطبيق الرئيسي - Attendance Admin
class AttendanceAdminApp extends StatelessWidget {
  final StorageService storageService;
  final NotificationService notificationService;
  final AppDatabase database;

  const AttendanceAdminApp({
    super.key,
    required this.storageService,
    required this.notificationService,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
        notificationServiceProvider.overrideWithValue(notificationService),
        databaseProvider.overrideWithValue(database),
      ],
      child: const _AttendanceAppState(),
    );
  }
}

class _AttendanceAppState extends ConsumerStatefulWidget {
  const _AttendanceAppState();

  @override
  ConsumerState<_AttendanceAppState> createState() => _AttendanceAppStateState();
}

class _AttendanceAppStateState extends ConsumerState<_AttendanceAppState> {
  late GoRouter _router;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _initRouter();
    _loadThemeMode();
  }

  void _initRouter() {
    _router = AppRouter.createRouter();
  }

  Future<void> _loadThemeMode() async {
    // تحميل وضع الثيم من التخزين المحلي
    final storageService = ref.read(storageServiceProvider);
    final isDark = storageService.getIsDarkMode();
    
    if (mounted) {
      setState(() {
        _themeMode = isDark == true ? ThemeMode.dark : (isDark == false ? ThemeMode.light : ThemeMode.system);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'نظام الحضور الذكي',
      
      // تكوين Go Router
      routerConfig: _router,
      
      // تكوين الثيم
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,

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
