/// شاشة قائمة الحضور
library;

import 'package:flutter/material.dart';

class AttendanceListScreen extends StatefulWidget {
  final String sessionId;

  const AttendanceListScreen({super.key, required this.sessionId});

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  
  // بيانات تجريبية
  List<Map<String, dynamic>> _attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() {
      _attendanceRecords = List.generate(35, (index) {
        late String status;
        if (index < 28) status = 'present';
        else if (index < 33) status = 'absent';
        else status = 'late';
        
        return {
          'id': '${index + 1}',
          'studentId': 'STU${(index + 1).toString().padLeft(4, '0')}',
          'name': 'طالب ${index + 1}',
          'status': status,
          'time': index < 28 
              ? DateTime.now().subtract(Duration(minutes: (index + 1) * 3))
              : null,
        };
      });
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredRecords {
    if (_searchQuery.isEmpty) return _attendanceRecords;
    
    return _attendanceRecords.where((record) {
      final name = record['name']?.toString().toLowerCase() ?? '';
      final studentId = record['studentId']?.toString() ?? '';
      return name.contains(_searchQuery.toLowerCase()) || 
             studentId.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الحضور'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {},
          ),
        ],
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
          _buildStatsBar(),

          // قائمة الحضور
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredRecords.isEmpty
                    ? Center(child: Text('لا توجد نتائج', style: TextStyle(color: Colors.grey[600])))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredRecords.length,
                        itemBuilder: (context, index) =>
                            _AttendanceRecordItem(record: _filteredRecords[index]),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    final presentCount = _attendanceRecords.where((r) => r['status'] == 'present').length;
    final absentCount = _attendanceRecords.where((r) => r['status'] == 'absent').length;
    final lateCount = _attendanceRecords.where((r) => r['status'] == 'late').length;

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
          _StatChip(label: 'الكل', value: '${_attendanceRecords.length}', color: Colors.grey),
          _StatChip(label: 'حاضر', value: '$presentCount', color: Colors.green),
          _StatChip(label: 'غائب', value: '$absentCount', color: Colors.red),
          _StatChip(label: 'متأخر', value: '$lateCount', color: Colors.orange),
        ],
      ),
    );
  }
}

class _AttendanceRecordItem extends StatelessWidget {
  final Map<String, dynamic> record;

  const _AttendanceRecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    final status = record['status'] as String;
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    switch (status) {
      case 'present':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'حاضر';
        break;
      case 'late':
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        statusText = 'متأخر';
        break;
      case 'absent':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'غائب';
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
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(statusIcon, color: statusColor, size: 20),
        ),
        title: Text(record['name'] ?? ''),
        subtitle: Text(record['studentId'] ?? ''),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              statusText,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
            ),
            if (record['time'] != null)
              Text(
                _formatTime(record['time']),
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
          ],
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
