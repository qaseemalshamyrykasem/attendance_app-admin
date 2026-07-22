/// شاشة التقارير — حقيقية مع Riverpod (بيانات من DB)
library;

import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../services/database/local_database.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'ملخص'),
            Tab(text: 'الحضور'),
            Tab(text: 'المقررات'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SummaryTab(),
          _AttendanceTab(),
          _CoursesTab(),
        ],
      ),
    );
  }
}

// ============================================
// تبويب الملخص
// ============================================

class _SummaryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        statsAsync.when(
          data: (stats) => Column(
            children: [
              Row(
                children: [
                  Expanded(child: _SummaryCard(title: 'إجمالي الطلاب', value: '${stats.totalStudents}', icon: Icons.people, color: Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _SummaryCard(title: 'جلسات نشطة', value: '${stats.activeSessions}', icon: Icons.play_circle, color: Colors.green)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _SummaryCard(title: 'حضور اليوم', value: '${stats.todayAttendance}', icon: Icons.check_circle, color: Colors.teal)),
                  const SizedBox(width: 12),
                  Expanded(child: _SummaryCard(title: 'المقررات', value: '${stats.totalCourses}', icon: Icons.book, color: Colors.purple)),
                ],
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('خطأ: $e')),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

// ============================================
// تبويب الحضور
// ============================================

class _AttendanceTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionListProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // إحصائيات الحضور
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إحصائيات الحضور', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                sessionsAsync.when(
                  data: (sessions) {
                    final totalSessions = sessions.length;
                    final activeSessions = sessions.where((s) => s.status == 'active').length;
                    final closedSessions = sessions.where((s) => s.status == 'closed').length;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _AttendanceStatItem(color: Colors.green, label: 'نشطة', count: activeSessions),
                        _AttendanceStatItem(color: Colors.grey, label: 'مغلقة', count: closedSessions),
                        _AttendanceStatItem(color: Colors.blue, label: 'إجمالي', count: totalSessions),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('خطأ: $e'),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // قائمة الجلسات الأخيرة
        sessionsAsync.when(
          data: (sessions) {
            if (sessions.isEmpty) {
              return Center(child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text('لا توجد جلسات', style: TextStyle(color: Colors.grey[600])),
              ));
            }

            return Column(
              children: sessions.take(10).map((session) => _DayAttendanceCard(
                session: session,
              ).build(context)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('خطأ: $e')),
        ),
      ],
    );
  }
}

class _AttendanceStatItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const _AttendanceStatItem({required this.color, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Center(child: Text('$count', style: TextStyle(fontWeight: FontWeight.bold, color: color))),
        ),
        const SizedBox(height: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _DayAttendanceCard extends ConsumerWidget {
  final SessionEntity session;

  const _DayAttendanceCard({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = DateUtils.isToday(session.date);
    final statsAsync = ref.watch(sessionAttendanceStatsProvider(session.id));

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isToday ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${session.date.day}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isToday ? Colors.white : null)),
              Text(_getMonthName(session.date.month), style: TextStyle(fontSize: 9, color: isToday ? Colors.white70 : Colors.grey[600])),
            ],
          ),
        ),
        title: Text(isToday ? 'اليوم' : DateUtils.formatDate(session.date)),
        subtitle: statsAsync.when(
          data: (stats) => Text('${stats.presentCount} حاضر • ${stats.absentCount} غائب • ${stats.lateCount} متأخر'),
          loading: () => const Text('جارٍ التحميل...'),
          error: (e, _) => Text('خطأ'),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return months[(month - 1) % 12];
  }
}

// ============================================
// تبويب المقررات
// ============================================

class _CoursesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(courseListProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        coursesAsync.when(
          data: (courses) {
            if (courses.isEmpty) {
              return Center(child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book_outlined, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text('لا توجد مقررات', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ));
            }

            return Column(
              children: courses.map((course) => _CourseReportCard(
                course: course,
              ).build(context, ref)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('خطأ: $e')),
        ),
      ],
    );
  }
}

class _CourseReportCard extends ConsumerWidget {
  final Course course;

  const _CourseReportCard({required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get session count for this course
    final sessionsAsync = ref.watch(sessionListProvider);

    final sessionCount = sessionsAsync.when(
      data: (sessions) => sessions.where((s) => s.courseId == course.id).length,
      loading: () => 0,
      error: (e, _) => 0,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text('${course.code ?? ''}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MiniStat(icon: Icons.event_outlined, value: '$sessionCount', label: 'جلسة'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MiniStat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: Colors.grey[600]),
      const SizedBox(width: 4),
      Text(value),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
    ]);
  }
}
