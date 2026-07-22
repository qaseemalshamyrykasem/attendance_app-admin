/// شاشة تفاصيل الجلسة
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionDetailScreen extends StatefulWidget {
  final String sessionId;

  const SessionDetailScreen({super.key, required this.sessionId});

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  // بيانات تجريبية
  Map<String, dynamic>? _sessionData;
  List<Map<String, dynamic>> _attendanceList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessionData();
  }

  Future<void> _loadSessionData() async {
    // محاكاة تحميل البيانات
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;

    setState(() {
      _sessionData = {
        'id': widget.sessionId,
        'courseName': 'برمجة متقدمة',
        'sectionName': 'شعبة أ',
        'date': DateTime.now(),
        'startTime': TimeOfDay.now(),
        'status': 'closed',
        'ip': '192.168.1.100',
        'port': 8080,
        'totalStudents': 35,
        'presentCount': 28,
        'absentCount': 5,
        'lateCount': 2,
      };
      
      _attendanceList = List.generate(28, (index) => {
        'id': '${index + 1}',
        'studentId': 'STU${(index + 1).toString().padLeft(4, '0')}',
        'name': 'طالب ${index + 1}',
        'status': index < 2 ? 'late' : 'present',
        'time': DateTime.now().subtract(Duration(minutes: (index + 1) * 5)),
      });
      
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                value: 'export_excel',
                child: Row(
                  children: [
                    Icon(Icons.table_chart, size: 20),
                    SizedBox(width: 8),
                    Text('تصدير Excel'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export_pdf',
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, size: 20),
                    SizedBox(width: 8),
                    Text('تصدير PDF'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'print',
                child: Row(
                  children: [
                    Icon(Icons.print, size: 20),
                    SizedBox(width: 8),
                    Text('طباعة'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_sessionData == null) {
      return const Center(child: Text('لم يتم العثور على بيانات الجلسة'));
    }

    return RefreshIndicator(
      onRefresh: _loadSessionData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // معلومات الجلسة
          _buildSessionInfoCard(),

          const SizedBox(height: 16),

          // إحصائيات الحضور
          _buildAttendanceStatsCard(),

          const SizedBox(height: 24),

          // قائمة الحضور
          _buildAttendanceListHeader(),

          const SizedBox(height: 12),

          ..._attendanceList.map((record) => _AttendanceRecordCard(record: record)),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSessionInfoCard() {
    final session = _sessionData!;
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
                    session['courseName'] ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
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
              '${session['sectionName']} • ${_formatDate(session['date'])}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.dns_outlined, 'الخادم', '${session['ip']}:${session['port']}'),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.people_outline, 'إجمالي الطلاب', '${session['totalStudents']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStatsCard() {
    final session = _sessionData!;
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                label: 'حاضر',
                value: '${session['presentCount']}',
                color: Colors.green,
              ),
            ),
            Container(width: 1, height: 40, color: Theme.of(context).dividerColor),
            Expanded(
              child: _StatItem(
                label: 'متأخر',
                value: '${session['lateCount']}',
                color: Colors.orange,
              ),
            ),
            Container(width: 1, height: 40, color: Theme.of(context).dividerColor),
            Expanded(
              child: _StatItem(
                label: 'غائب',
                value: '${session['absentCount']}',
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text('$label:', style: Theme.of(context).textTheme.bodySmall),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildAttendanceListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'سجل الحضور (${_attendanceList.length})',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
      case 'export_excel':
        _showSnackBar('جارٍ تصدير ملف Excel...');
        break;
      case 'export_pdf':
        _showSnackBar('جارٍ تصدير ملف PDF...');
        break;
      case 'print':
        _showSnackBar('جارٍ الطباعة...');
        break;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  String _formatDate(dynamic date) {
    if (date is DateTime) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
    return date.toString();
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
  final Map<String, dynamic> record;

  const _AttendanceRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final status = record['status'] as String;
    Color statusColor;
    String statusText;
    
    switch (status) {
      case 'present':
        statusColor = Colors.green;
        statusText = 'حاضر';
        break;
      case 'late':
        statusColor = Colors.orange;
        statusText = 'متأخر';
        break;
      case 'absent':
        statusColor = Colors.red;
        statusText = 'غائب';
        break;
      default:
        statusColor = Colors.grey;
        statusText = status;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(
            status == 'present' ? Icons.check : (status == 'late' ? Icons.schedule : Icons.close),
            color: statusColor,
            size: 18,
          ),
        ),
        title: Text(record['name'] ?? ''),
        subtitle: Text('${record['studentId']} • ${_formatTime(record['time'])}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statusText,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
          ),
        ),
      ),
    );
  }

  String _formatTime(dynamic time) {
    if (time is DateTime) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '';
  }
}
