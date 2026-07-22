/// شاشة إدارة المقررات
library;

import 'package:flutter/material.dart';

class CourseManagementScreen extends StatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  
  // بيانات تجريبية
  List<Map<String, dynamic>> _courses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() {
      _courses = [
        {'id': '1', 'name': 'برمجة متقدمة', 'code': 'CS401', 'sectionName': 'شعبة أ', 'sessionsCount': 12},
        {'id': '2', 'name': 'قواعد بيانات', 'code': 'CS302', 'sectionName': 'شعبة ب', 'sessionsCount': 8},
        {'id': '3', 'name': 'ذكاء اصطناعي', 'code': 'CS405', 'sectionName': 'شعبة ج', 'sessionsCount': 15},
        {'id': '4', 'name': 'شبكات الحاسوب', 'code': 'CS303', 'sectionName': 'شعبة أ', 'sessionsCount': 10},
        {'id': '5', 'name': 'هندسة البرمجيات', 'code': 'CS402', 'sectionName': 'شعبة د', 'sessionsCount': 6},
      ];
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredCourses {
    if (_searchQuery.isEmpty) return _courses;
    
    return _courses.where((course) {
      final name = course['name']?.toString().toLowerCase() ?? '';
      final code = course['code']?.toString().toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase()) || code.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المقررات'),
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'بحث بمسمى المقرر أو الرمز...',
                prefixIcon: const Icon(Icons.search_outlined),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchQuery = ''))
                    : null,
              ),
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCourses.isEmpty
                    ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.book_outlined, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد مقررات', style: TextStyle(color: Colors.grey[600])),
                      ]))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredCourses.length,
                        itemBuilder: (context, index) =>
                            _CourseCard(course: _filteredCourses[index]),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add),
        label: const Text('مقرر جديد'),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _CourseFormDialog(onSave: (courseData) async {
        Navigator.pop(ctx);
        setState(() {
          _courses.add({
            ...courseData,
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'sessionsCount': 0,
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إضافة المقرر بنجاح')),
        );
      }),
    );
  }
}

// ============================================
// Widgets فرعية
// ============================================

class _CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              course['code']?.toString().substring(0, 2).toUpperCase() ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        title: Text(course['name'] ?? ''),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.book_outlined, size: 14),
            Text('${course['sectionName']}'),
            const SizedBox(width: 12),
            const Icon(Icons.event_outlined, size: 14),
            Text('${course['sessionsCount']} جلسة'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleAction(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('تعديل')])),
            const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('حذف', style: TextStyle(color: Colors.red))])),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: 'رمز المقرر', value: course['code']),
                _InfoRow(label: 'الشعبة', value: course['sectionName']),
                _InfoRow(label: 'عدد الجلسات', value: '${course['sessionsCount']}'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility, size: 18),
                      label: const Text('عرض الجلسات'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فتح تعديل المقرر')));
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
        title: const Text('حذف المقرر'),
        content: const Text('هل أنت متأكد من حذف هذا المقرر؟'),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label:', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const Spacer(),
          Text(value ?? '-', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }
}

// ============================================
// نموذج إضافة/تعديل مقرر
// ============================================

class _CourseFormDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const _CourseFormDialog({required this.onSave});

  @override
  State<_CourseFormDialog> createState() => _CourseFormDialogState();
}

class _CourseFormDialogState extends State<_CourseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة مقرر جديد'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المقرر *',
                prefixIcon: Icon(Icons.book_outlined),
              ),
              validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال الاسم' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'رمز المقرر',
                prefixIcon: Icon(Icons.code_outlined),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave({
                'name': _nameController.text,
                'code': _codeController.text.isEmpty ? 'NEW' : _codeController.text.toUpperCase(),
                'sectionName': 'بدون شعبة',
              });
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
}
