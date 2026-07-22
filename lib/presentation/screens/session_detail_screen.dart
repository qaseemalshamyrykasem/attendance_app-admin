/// شاشة تفاصيل الجلسة — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class SessionDetailScreen extends ConsumerStatefulWidget {
  final String sessionId;

  const SessionDetailScreen({super.key, required this.sessionId});

  @override
  ConsumerState<SessionDetailScreen> createState() =>
      _SessionDetailScreenState();
}

class _SessionDetailScreenState extends ConsumerState<SessionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionDetailProvider(widget.sessionId));
    final statsAsync =
        ref.watch(sessionAttendanceStatsProvider(widget.sessionId));
    final attendanceAsync =
        ref.watch(sessionAttendanceProvider(widget.sessionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الجلسة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
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
                value: 'export_excel',
                child: Row(
                  children: [
                    Icon(Icons.table_chart, size: 20),
                    SizedBox(width: 8),
                    Text('تصدير Excel'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: sessionAsync.when(
        data: (session) {
          if (session == null) {
            return const Center(child: Text('لم يتم العثور على بيانات الجلسة'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(sessionDetailProvider(widget.sessionId));
              ref.invalidate(sessionAttendanceStatsProvider(widget.sessionId));
              ref.invalidate(sessionAttendanceProvider(widget.sessionId));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSessionInfoCard(session),
                const SizedBox(height: 16),
                statsAsync.when(
                  data: (stats) => _buildAttendanceStatsCard(stats),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 24),
                _buildAttendanceListHeader(attendanceAsync),
                const SizedBox(height: 12),
                attendanceAsync.when(
                  data: (records) => Column(
                    children: records
                        .map((record) => _AttendanceRecordCard(record: record))
                        .toList(),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('خطأ: $e')),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
      ),
    );
  }

  Widget _buildSessionInfoCard(SessionEntity session) {
    final status = session.status;
    Color statusColor = Colors.grey;
    String statusText = FormatUtils.sessionStatusToArabic(status);

    switch (status) {
      case 'active':
        statusColor = Colors.green;
        break;
      case 'closed':
        statusColor = Colors.grey;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    session.courseName ?? session.courseId,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${session.sectionName ?? session.sectionId} • ${AppDateUtils.formatDate(session.date)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const Divider(height: 24),
            if (session.ip != null)
              _buildInfoRow(Icons.dns_outlined, 'الخادم',
                  '${session.ip}:${session.port ?? 8080}'),
            _buildInfoRow(Icons.access_time_outlined, 'بدء الجلسة',
                AppDateUtils.formatTime(session.startTime, pattern: 'HH:mm')),
            if (session.endTime != null)
              _buildInfoRow(Icons.access_time_filled_rounded, 'نهاية الجلسة',
                  AppDateUtils.formatTime(session.endTime!, pattern: 'HH:mm')),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStatsCard(AttendanceStats stats) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                label: 'حاضر',
                value: '${stats.presentCount}',
                color: Colors.green,
              ),
            ),
            Container(
                width: 1, height: 40, color: Theme.of(context).dividerColor),
            Expanded(
              child: _StatItem(
                label: 'متأخر',
                value: '${stats.lateCount}',
                color: Colors.orange,
              ),
            ),
            Container(
                width: 1, height: 40, color: Theme.of(context).dividerColor),
            Expanded(
              child: _StatItem(
                label: 'غائب',
                value: '${stats.absentCount}',
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text('$label:', style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildAttendanceListHeader(
      AsyncValue<List<AttendanceEntity>> attendanceAsync) {
    final count = attendanceAsync.when(
      data: (records) => records.length,
      loading: () => 0,
      error: (e, _) => 0,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'سجل الحضور ($count)',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton.icon(
          onPressed: () => context.push('/attendance/${widget.sessionId}'),
          icon: const Icon(Icons.fullscreen_outlined, size: 18),
          label: const Text('عرض الكل'),
        ),
      ],
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'refresh':
        ref.invalidate(sessionDetailProvider(widget.sessionId));
        ref.invalidate(sessionAttendanceStatsProvider(widget.sessionId));
        ref.invalidate(sessionAttendanceProvider(widget.sessionId));
        break;
      case 'export_excel':
        UiUtils.showSnackBar(context, 'جارٍ تصدير ملف Excel...');
        break;
    }
  }
}

// ============================================
// Widgets فرعية
// ============================================

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _AttendanceRecordCard extends StatelessWidget {
  final AttendanceEntity record;

  const _AttendanceRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final status = record.status;
    Color statusColor = Colors.grey;
    String statusText = status;
    IconData statusIcon = Icons.help;

    switch (status) {
      case 'present':
        statusColor = Colors.green;
        statusText = FormatUtils.statusToArabic(status);
        statusIcon = Icons.check;
        break;
      case 'late':
        statusColor = Colors.orange;
        statusText = FormatUtils.statusToArabic(status);
        statusIcon = Icons.schedule;
        break;
      case 'absent':
        statusColor = Colors.red;
        statusText = FormatUtils.statusToArabic(status);
        statusIcon = Icons.close;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.1),
          child: Icon(statusIcon, color: statusColor, size: 18),
        ),
        title: Text(record.student?.name ?? record.studentId),
        subtitle: Text(
            '${record.studentId} • ${AppDateUtils.formatTime(record.timestamp, pattern: 'HH:mm')}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statusText,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
          ),
        ),
      ),
    );
  }
}
