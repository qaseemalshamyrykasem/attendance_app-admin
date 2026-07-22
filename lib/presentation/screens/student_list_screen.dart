/// شاشة قائمة الطلاب
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  String? _filterSectionId = 'all';
  
  // بيانات تجريبية
  List<Map<String, dynamic>> _students = [];
  
  final List<Map<String, dynamic>> _sections = [
    {'id': '1', 'name': 'شعبة أ'},
    {'id': '2', 'name': 'شعبة ب'},
    {'id': '3', 'name': 'شعبة ج'},
  ];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() {
      _students = List.generate(50, (index) => {
        'id': '${index + 1}',
        'studentId': 'STU${(index + 1).toString().padLeft(4, '0')}',
        'name': 'طالب ${index + 1}',
        'sectionId': '${(index % 3) + 1}',
        'sectionName': 'شعبة ${['أ', 'ب', 'ج'][index % 3]}',
        'phone': '05${12345678 + index}',
      });
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredStudents {
    var result = _students;
    
    if (_searchQuery.isNotEmpty) {
      result = result.where((student) {
        final name = student['name']?.toString().toLowerCase() ?? '';
        final studentId = student['studentId']?.toString() ?? '';
        return name.contains(_searchQuery.toLowerCase()) || 
               studentId.contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    if (_filterSectionId != null && _filterSectionId != 'all') {
      result = result.where((s) => s['sectionId'] == _filterSectionId).toList();
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الطلاب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.import_export_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث والتصفية
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'بحث...',
                      prefixIcon: const Icon(Icons.search_outlined),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchQuery = ''))
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _filterSectionId,
                  hint: const Text('الكل'),
                  items: [
                    const DropdownMenuItem(value: 'all', child: Text('الكل')),
                    ..._sections.map((s) => DropdownMenuItem(
                      value: s['id'] as String,
                      child: Text(s['name'] as String),
                    )),
                  ],
                  onChanged: (value) => setState(() => _filterSectionId = value),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredStudents.isEmpty
                    ? Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text('لا يوجد طلاب', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredStudents.length,
                        itemBuilder: (context, index) =>
                            _StudentCard(student: _filteredStudents[index]),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/students/student/add'),
        icon: const Icon(Icons.person_add),
        label: const Text('إضافة طالب'),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final Map<String, dynamic> student;

  const _StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            (student['name'] as String).substring(0, 1),
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(student['name'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${student['studentId']} • ${student['sectionName']}'),
            if (student['phone'] != null)
              Text(student['phone'].toString(), style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleAction(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'view', child: Row(children: [Icon(Icons.visibility, size: 18), SizedBox(width: 8), Text('عرض')])),
            const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('تعديل')])),
            const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('حذف', style: TextStyle(color: Colors.red))])),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'view':
        context.push('/student/${student['id']}');
        break;
      case 'edit':
        context.push('/student/${student['id']}');
        break;
      case 'delete':
        _showDeleteConfirmation(context);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: const Text('هل أنت متأكد من حذف هذا الطالب؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
