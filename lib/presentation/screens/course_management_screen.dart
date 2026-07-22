/// شاشة إدارة المقررات — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../services/database/local_database.dart';

class CourseManagementScreen extends ConsumerStatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  ConsumerState<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends ConsumerState<CourseManagementScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(courseListProvider);

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
            child: coursesAsync.when(
              data: (courses) {
                final filtered = _filterCourses(courses);

                if (filtered.isEmpty) {
                  return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.book_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('لا توجد مقررات', style: TextStyle(color: Colors.grey[600])),
                    ]));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) =>
                      _CourseCard(course: filtered[index], onEdit: () => _editCourse(filtered[index]), onDelete: () => _deleteCourse(filtered[index])),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
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

  List<Course> _filterCourses(List<Course> courses) {
    if (_searchQuery.isEmpty) return courses;

    return courses.where((course) {
      final name = course.name.toLowerCase();
      final code = (course.code ?? '').toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          code.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _showAddDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة مقرر جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المقرر *',
                prefixIcon: Icon(Icons.book_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'رمز المقرر',
                prefixIcon: Icon(Icons.code_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;

              final database = ref.read(databaseProvider);
              await database.insertCourse(CoursesCompanion(
                id: drift.Value(DateTime.now().millisecondsSinceEpoch.toString()),
                name: drift.Value(nameController.text.trim()),
                code: drift.Value(codeController.text.trim().isEmpty ? null : codeController.text.trim().toUpperCase()),
              ));

              Navigator.pop(ctx);
              ref.invalidate(courseListProvider);
              ref.invalidate(dashboardStatsProvider);
              UiUtils.showSnackBar(context, 'تمت إضافة المقرر بنجاح');
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCourse(Course course) async {
    final confirm = await UiUtils.showConfirmationDialog(
      context,
      title: 'حذف المقرر',
      message: 'هل أنت متأكد من حذف المقرر "${course.name}"؟',
      isDestructive: true,
    );

    if (confirm) {
      final database = ref.read(databaseProvider);
      await database.deleteCourse(course.id);
      ref.invalidate(courseListProvider);
      ref.invalidate(dashboardStatsProvider);
      UiUtils.showSnackBar(context, 'تم حذف المقرر بنجاح');
    }
  }

  void _editCourse(Course course) {
    final nameController = TextEditingController(text: course.name);
    final codeController = TextEditingController(text: course.code ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل المقرر'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المقرر *',
                prefixIcon: Icon(Icons.book_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'رمز المقرر',
                prefixIcon: Icon(Icons.code_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;

              final database = ref.read(databaseProvider);
              await database.updateCourse(Course(
                id: course.id,
                name: nameController.text.trim(),
                code: codeController.text.trim().isEmpty ? null : codeController.text.trim().toUpperCase(),
                sectionId: course.sectionId,
                createdAt: course.createdAt,
              ));

              Navigator.pop(ctx);
              ref.invalidate(courseListProvider);
              UiUtils.showSnackBar(context, 'تم تحديث المقرر بنجاح');
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CourseCard({required this.course, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              (course.code ?? course.name.substring(0, 2)).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(course.code ?? ''),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('تعديل')])),
            const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('حذف', style: TextStyle(color: Colors.red))])),
          ],
        ),
      ),
    );
  }
}
