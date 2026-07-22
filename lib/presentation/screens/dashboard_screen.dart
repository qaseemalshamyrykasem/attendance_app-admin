/// شاشة لوحة التحكم (Dashboard)
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // بيانات تجريبية - ستُستبدل بالبيانات الحقيقية من API
  final Map<String, dynamic> _stats = {
    'totalStudents': 156,
    'activeSessions': 2,
    'todayAttendance': 89,
    'todayAbsence': 12,
    'totalCourses': 8,
    'totalSections': 6,
  };

  List<Map<String, dynamic>> _recentSessions = [
    {
      'id': '1',
      'courseName': 'برمجة متقدمة',
      'sectionName': 'شعبة أ',
      'date': DateTime.now(),
      'status': 'active',
      'attendanceCount': 28,
    },
    {
      'id': '2',
      'courseName': 'قواعد بيانات',
      'sectionName': 'شعبة ب',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'status': 'closed',
      'attendanceCount': 32,
    },
    {
      'id': '3',
      'courseName': 'ذكاء اصطناعي',
      'sectionName': 'شعبة ج',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'closed',
      'attendanceCount': 25,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'refresh') {
                _refreshData();
              } else if (value == 'export') {
                _exportData();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20),
                    SizedBox(width: 8),
                    Text('تحديث'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.file_download_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('تصدير تقرير'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // بطاقات الإحصائيات
            _buildStatsGrid(),

            const SizedBox(height: 24),

            // زر إنشاء جلسة جديدة
            _buildCreateSessionButton(),

            const SizedBox(height: 24),

            // آخر الجلسات
            _buildRecentSessionsSection(),

            const SizedBox(height: 24),

            // إجراءات سريعة
            _buildQuickActions(),

            const SizedBox(height: 80), // مساحة لـ FAB
          ],
        ),
      ),

      // زر عائم لإنشاء جلسة
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/dashboard/session/create'),
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('جلسة جديدة'),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _StatCard(
          title: 'إجمالي الطلاب',
          value: '${_stats['totalStudents']}',
          icon: Icons.people_rounded,
          color: Colors.blue,
          animation: _animationController,
          delay: 0,
        ),
        _StatCard(
          title: 'جلسات نشطة',
          value: '${_stats['activeSessions']}',
          icon: Icons.play_circle_rounded,
          color: Colors.green,
          animation: _animationController,
          delay: 100,
        ),
        _StatCard(
          title: 'حضور اليوم',
          value: '${_stats['todayAttendance']}',
          icon: Icons.check_circle_rounded,
          color: Colors.teal,
          animation: _animationController,
          delay: 200,
        ),
        _StatCard(
          title: 'غائبون اليوم',
          value: '${_stats['todayAbsence']}',
          icon: Icons.cancel_rounded,
          color: Colors.red,
          animation: _animationController,
          delay: 300,
        ),
      ],
    );
  }

  Widget _buildCreateSessionButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => context.push('/dashboard/session/create'),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            const Text(
              'إنشاء جلسة حضور جديدة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSessionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'آخر الجلسات',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ..._recentSessions.map((session) => _SessionCard(session: session)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إجراءات سريعة',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _QuickActionTile(
                icon: Icons.person_add_outlined,
                label: 'إضافة طالب',
                color: Colors.blue,
                onTap: () => context.push('/students/student/add'),
              ),
              const SizedBox(width: 12),
              _QuickActionTile(
                icon: Icons.import_export_outlined,
                label: 'استيراد طلاب',
                color: Colors.orange,
                onTap: () {},
              ),
              const SizedBox(width: 12),
              _QuickActionTile(
                icon: Icons.backup_outlined,
                label: 'نسخ احتياطي',
                color: Colors.purple,
                onTap: () => context.push('/settings/backup'),
              ),
              const SizedBox(width: 12),
              _QuickActionTile(
                icon: Icons.assessment_outlined,
                label: 'تقرير شهري',
                color: Colors.teal,
                onTap: () => context.push('/reports'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _exportData() async {}
}

// ============================================
// Widgets فرعية
// ============================================

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final AnimationController animation;
  final int delay;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.animation,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + delay),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: child,
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Spacer(),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final status = session['status'] as String;
    Color statusColor;
    String statusText;
    
    switch (status) {
      case 'active':
        statusColor = Colors.green;
        statusText = 'نشطة';
        break;
      case 'closed':
        statusColor = Colors.grey;
        statusText = 'مغلقة';
        break;
      default:
        statusColor = Colors.orange;
        statusText = status;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.push('/dashboard/session/${session['id']}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  status == 'active' ? Icons.play_arrow : Icons.check,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['courseName'] ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${session['sectionName']} • ${session['attendanceCount']} حاضر',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
