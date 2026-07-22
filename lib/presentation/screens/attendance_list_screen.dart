/// شاشة قائمة الحضور — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class AttendanceListScreen extends ConsumerStatefulWidget {
  final String sessionId;

  const AttendanceListScreen({super.key, required this.sessionId});

  @override
  ConsumerState<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends ConsumerState<AttendanceListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final attendanceAsync = ref.watch(sessionAttendanceProvider(widget.sessionId));
    final statsAsync = ref.watch(sessionAttendanceStatsProvider(widget.sessionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الحضور'),
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'بحث بالاسم أو الرقم الجامعي...',
                prefixIcon: const Icon(Icons.search_outlined),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ),
          ),

          // إحصائيات
          statsAsync.when(
            data: (stats) => _buildStatsBar(stats),
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
          ),

          // قائمة الحضور
          Expanded(
            child: attendanceAsync.when(
              data: (records) {
                final filtered = _filterRecords(records);

                if (filtered.isEmpty) {
                  return Center(child: Text('لا توجد نتائج', style: TextStyle(color: Colors.grey[600])));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) =>
                      _AttendanceRecordItem(record: filtered[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
            ),
          ),
        ],
      ),
    );
  }

  List<AttendanceEntity> _filterRecords(List<AttendanceEntity> records) {
    if (_searchQuery.isEmpty) return records;

    return records.where((record) {
      final name = record.student?.name.toLowerCase() ?? '';
      final studentId = record.studentId.toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          studentId.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildStatsBar(AttendanceStats stats) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatChip(label: 'الكل', value: '${stats.totalCount}', color: Colors.grey),
          _StatChip(label: 'حاضر', value: '${stats.presentCount}', color: Colors.green),
          _StatChip(label: 'غائب', value: '${stats.absentCount}', color: Colors.red),
          _StatChip(label: 'متأخر', value: '${stats.lateCount}', color: Colors.orange),
        ],
      ),
    );
  }
}

class _AttendanceRecordItem extends StatelessWidget {
  final AttendanceEntity record;

  const _AttendanceRecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    final status = record.status;
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status) {
      case 'present':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = FormatUtils.statusToArabic(status);
        break;
      case 'late':
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        statusText = FormatUtils.statusToArabic(status);
        break;
      case 'absent':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = FormatUtils.statusToArabic(status);
        break;
      case 'excused':
        statusColor = Colors.blue;
        statusIcon = Icons.info;
        statusText = FormatUtils.statusToArabic(status);
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
        statusText = status;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.1),
          child: Icon(statusIcon, color: statusColor, size: 20),
        ),
        title: Text(record.student?.name ?? record.studentId),
        subtitle: Text(record.studentId),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              statusText,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
            ),
            Text(
              AppDateUtils.formatTime(record.timestamp, pattern: 'HH:mm'),
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}
