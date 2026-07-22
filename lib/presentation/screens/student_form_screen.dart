/// شاشة إضافة/تعديل طالب
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentFormScreen extends StatefulWidget {
  final String? studentId;

  const StudentFormScreen({super.key, this.studentId});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String? _selectedDepartmentId;
  String? _selectedSectionId;
  int? _selectedLevel;
  
  bool _isLoading = false;
  bool _isEditing = false;

  // بيانات تجريبية
  final List<Map<String, dynamic>> _departments = [
    {'id': '1', 'name': 'قسم الحاسب'},
    {'id': '2', 'name': 'قسم هندسة البرمجيات'},
    {'id': '3', 'name': 'قسم الشبكات'},
  ];

  final List<Map<String, dynamic>> _sections = [
    {'id': '1', 'name': 'شعبة أ'},
    {'id': '2', 'name': 'شعبة ب'},
    {'id': '3', 'name': 'شعبة ج'},
    {'id': '4', 'name': 'شعبة د'},
  ];

  final List<Map<String, dynamic>> _levels = [
    {'value': 1, 'name': 'المستوى الأول'},
    {'value': 2, 'name': 'المستوى الثاني'},
    {'value': 3, 'name': 'المستوى الثالث'},
    {'value': 4, 'name': 'المستوى الرابع'},
  ];

  @override
  void initState() {
    super.initState();
    _isEditing = widget.studentId != null;
    
    if (_isEditing) {
      _loadStudentData();
    }
  }

  Future<void> _loadStudentData() async {
    // محاكاة تحميل بيانات الطالب للتعديل
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!mounted) return;
    
    setState(() {
      _nameController.text = 'طالب موجود';
      _studentIdController.text = widget.studentId ?? '';
      _phoneController.text = '0501234567';
      _selectedDepartmentId = '1';
      _selectedSectionId = '1';
      _selectedLevel = 2;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'تعديل بيانات طالب' : 'إضافة طالب جديد'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _showDeleteConfirmation,
              tooltip: 'حذف',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // صورة الطالب (اختياري)
            _buildPhotoSection(),

            const SizedBox(height: 24),

            // الاسم
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'اسم الطالب *',
                hintText: 'أدخل اسم الطالب الكامل',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال اسم الطالب';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // الرقم الجامعي
            TextFormField(
              controller: _studentIdController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'الرقم الجامعي *',
                hintText: 'مثال: STU0001',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال الرقم الجامعي';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // رقم الهاتف
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف',
                hintText: '05xxxxxxxx',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: 16),

            // القسم
            DropdownButtonFormField<String>(
              value: _selectedDepartmentId,
              decoration: const InputDecoration(
                labelText: 'القسم',
                prefixIcon: Icon(Icons.business_outlined),
              ),
              items: _departments.map((dept) => DropdownMenuItem(
                value: dept['id'] as String,
                child: Text(dept['name'] as String),
              )).toList(),
              onChanged: (value) => setState(() => _selectedDepartmentId = value),
            ),

            const SizedBox(height: 16),

            // المستوى والشعبة في صف واحد
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedLevel,
                    decoration: const InputDecoration(
                      labelText: 'المستوى',
                      prefixIcon: Icon(Icons.layers_outlined),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: _levels.map((level) => DropdownMenuItem(
                      value: level['value'] as int,
                      child: Text(level['name'] as String),
                    )).toList(),
                    onChanged: (value) => setState(() => _selectedLevel = value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSectionId,
                    decoration: const InputDecoration(
                      labelText: 'الشعبة',
                      prefixIcon: Icon(Icons.group_outlined),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: _sections.map((section) => DropdownMenuItem(
                      value: section['id'] as String,
                      child: Text(section['name'] as String),
                    )).toList(),
                    onChanged: (value) => setState(() => _selectedSectionId = value),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // أزرار الإجراءات
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).dividerColor, width: 2),
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.photo_library_outlined, size: 18),
            label: const Text('إضافة صورة'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        FilledButton.icon(
          onPressed: _isLoading ? null : _saveStudent,
          icon: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Icon(_isEditing ? Icons.save_outlined : Icons.person_add_outlined),
          label: Text(_isLoading ? 'جارٍ الحفظ...' : (_isEditing ? 'حفظ التعديلات' : 'إضافة الطالب')),
          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
          label: const Text('رجوع'),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
        ),
      ],
    );
  }

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing ? 'تم تحديث البيانات بنجاح' : 'تمت إضافة الطالب بنجاح')),
      );
      
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Theme.of(context).colorScheme.error),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: const Text('هل أنت متأكد من حذف هذا الطالب؟ لا يمكن التراجع عن هذا الإجراء.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
