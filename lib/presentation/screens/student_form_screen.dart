/// شاشة إضافة/تعديل طالب — حقيقية مع Riverpod + use cases
library;

import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../services/database/local_database.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final String? studentId;

  const StudentFormScreen({super.key, this.studentId});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedDepartmentId;
  String? _selectedSectionId;
  int? _selectedLevel;

  bool _isLoading = false;
  bool _isEditing = false;
  StudentEntity? _existingStudent;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.studentId != null;

    if (_isEditing) {
      _loadStudentData();
    }
  }

  Future<void> _loadStudentData() async {
    // Load existing student data from the student list provider
    final studentsAsync = ref.read(studentListProvider);
    studentsAsync.whenData((students) {
      final student = students.where((s) => s.id == widget.studentId).firstOrNull;
      if (student != null) {
        setState(() {
          _existingStudent = student;
          _nameController.text = student.name;
          _studentIdController.text = student.studentId;
          _phoneController.text = student.phone ?? '';
          _selectedDepartmentId = student.departmentId;
          _selectedSectionId = student.sectionId;
          _selectedLevel = student.level;
        });
      }
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
    final departmentsAsync = ref.watch(departmentListProvider);
    final sectionsAsync = ref.watch(sectionListProvider);

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
            departmentsAsync.when(
              data: (departments) => DropdownButtonFormField<String>(
                value: _selectedDepartmentId,
                decoration: const InputDecoration(
                  labelText: 'القسم',
                  prefixIcon: Icon(Icons.business_outlined),
                ),
                items: departments.map((dept) => DropdownMenuItem(
                  value: dept.id,
                  child: Text(dept.name),
                )).toList(),
                onChanged: (value) => setState(() => _selectedDepartmentId = value),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('خطأ في تحميل الأقسام'),
            ),

            const SizedBox(height: 16),

            // المستوى والشعبة
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
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('المستوى الأول')),
                      DropdownMenuItem(value: 2, child: Text('المستوى الثاني')),
                      DropdownMenuItem(value: 3, child: Text('المستوى الثالث')),
                      DropdownMenuItem(value: 4, child: Text('المستوى الرابع')),
                    ],
                    onChanged: (value) => setState(() => _selectedLevel = value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: sectionsAsync.when(
                    data: (sections) => DropdownButtonFormField<String>(
                      value: _selectedSectionId,
                      decoration: const InputDecoration(
                        labelText: 'الشعبة',
                        prefixIcon: Icon(Icons.group_outlined),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      items: sections.map((section) => DropdownMenuItem(
                        value: section.id,
                        child: Text(section.name),
                      )).toList(),
                      onChanged: (value) => setState(() => _selectedSectionId = value),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('خطأ'),
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
      final student = StudentEntity(
        id: _isEditing ? _existingStudent!.id : DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        departmentId: _selectedDepartmentId,
        sectionId: _selectedSectionId,
        level: _selectedLevel,
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      );

      if (_isEditing) {
        await ref.read(updateStudentUseCaseProvider)(student);
      } else {
        await ref.read(addStudentUseCaseProvider)(student);
      }

      if (!mounted) return;

      // Invalidate the student list provider to refresh data
      ref.invalidate(studentListProvider);
      ref.invalidate(studentCountProvider);
      ref.invalidate(dashboardStatsProvider);

      UiUtils.showSnackBar(context, _isEditing ? 'تم تحديث البيانات بنجاح' : 'تمت إضافة الطالب بنجاح');

      context.pop();
    } catch (e) {
      if (!mounted) return;
      UiUtils.showSnackBar(context, 'خطأ: $e',
          backgroundColor: Theme.of(context).colorScheme.error);
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
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref.read(deleteStudentUseCaseProvider)(_existingStudent!.id);
                if (!mounted) return;
                ref.invalidate(studentListProvider);
                ref.invalidate(studentCountProvider);
                ref.invalidate(dashboardStatsProvider);
                UiUtils.showSnackBar(context, 'تم حذف الطالب بنجاح');
                context.pop();
              } catch (e) {
                if (mounted) {
                  UiUtils.showSnackBar(context, 'خطأ: $e',
                      backgroundColor: Theme.of(context).colorScheme.error);
                }
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
