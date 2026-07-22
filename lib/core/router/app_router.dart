/// إعداد Go Router للتنقل في التطبيق
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

/// مسارات التطبيق
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String sessionCreate = '/session/create';
  static const String sessionDetail = '/session/:id';
  static const String sessionActive = '/session/active';
  static const String attendanceList = '/attendance/:sessionId';
  static const String studentList = '/students';
  static const String studentAdd = '/student/add';
  static const String studentEdit = '/student/:id';
  static const String courseList = '/courses';
  static const String sectionList = '/sections';
  static const String departmentList = '/departments';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String backup = '/backup';
  static const String about = '/about';
}

/// مفتاح التنقل
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// إعداد Go Router
class AppRouter {
  AppRouter._();

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => _ErrorScreen(error: state.error),
      routes: [
        // شاشة البداية
        GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        // شاشة تسجيل الدخول
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),

        // شاشة لوحة التحكم (Shell Route)
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScreen(navigationShell: navigationShell);
          },
          branches: [
            // الفرع الرئيسي - لوحة التحكم
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.dashboard,
                  name: 'dashboard',
                  builder: (context, state) => const DashboardScreen(),
                  routes: [
                    // إنشاء جلسة جديدة
                    GoRoute(
                      path: 'session/create',
                      name: 'session_create',
                      builder: (context, state) => const SessionCreateScreen(),
                    ),
                    // تفاصيل الجلسة
                    GoRoute(
                      path: 'session/:id',
                      name: 'session_detail',
                      builder: (context, state) {
                        final sessionId = state.pathParameters['id']!;
                        return SessionDetailScreen(sessionId: sessionId);
                      },
                    ),
                    // الجلسة النشطة
                    GoRoute(
                      path: 'session/active',
                      name: 'session_active',
                      builder: (context, state) => const ActiveSessionScreen(),
                    ),
                    // قائمة الحضور
                    GoRoute(
                      path: 'attendance/:sessionId',
                      name: 'attendance_list',
                      builder: (context, state) {
                        final sessionId = state.pathParameters['sessionId']!;
                        return AttendanceListScreen(sessionId: sessionId);
                      },
                    ),
                  ],
                ),
              ],
            ),

            // فرع الطلاب
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.studentList,
                  name: 'student_list',
                  builder: (context, state) => const StudentListScreen(),
                  routes: [
                    GoRoute(
                      path: 'student/add',
                      name: 'student_add',
                      parentNavigatorKey: navigatorKey,
                      builder: (context, state) => const StudentFormScreen(),
                    ),
                    GoRoute(
                      path: 'student/:id',
                      name: 'student_edit',
                      parentNavigatorKey: navigatorKey,
                      builder: (context, state) {
                        final studentId = state.pathParameters['id']!;
                        return StudentFormScreen(studentId: studentId);
                      },
                    ),
                  ],
                ),
              ],
            ),

            // فرع المقررات والشعب والأقسام
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.courseList,
                  name: 'course_list',
                  builder: (context, state) => const CourseManagementScreen(),
                ),
                GoRoute(
                  path: AppRoutes.sectionList,
                  name: 'section_list',
                  builder: (context, state) => const SectionManagementScreen(),
                ),
                GoRoute(
                  path: AppRoutes.departmentList,
                  name: 'department_list',
                  builder: (context, state) => const DepartmentManagementScreen(),
                ),
              ],
            ),

            // فرع التقارير
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.reports,
                  name: 'reports',
                  builder: (context, state) => const ReportsScreen(),
                ),
              ],
            ),

            // فرع الإعدادات
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.settings,
                  name: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                  routes: [
                    GoRoute(
                      path: 'backup',
                      name: 'backup',
                      parentNavigatorKey: navigatorKey,
                      builder: (context, state) => const BackupScreen(),
                    ),
                    GoRoute(
                      path: 'about',
                      name: 'about',
                      parentNavigatorKey: navigatorKey,
                      builder: (context, state) => const AboutScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// شاشة الخطأ
class _ErrorScreen extends StatelessWidget {
  final Exception? error;

  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'حدث خطأ',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'خطأ غير معروف',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}
