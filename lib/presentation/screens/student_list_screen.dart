/// شاشة قائمة الطلاب — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../services/database/local_database.dart';

class StudentListScreen extends ConsumerStatefulWidget {
  const StudentListScreen({super.key});

  @override
  ConsumerState<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends ConsumerState<StudentListScreen> {
  String _searchQuery = '';
  String? _filterSectionId;

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(studentListProvider);
    final sectionsAsync = ref.watch(sectionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الطلاب'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {
              _showFilterDialog(sectionsAsync);
            },
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

          // قائمة الطلاب
          Expanded(
            child: studentsAsync.when(
              data: (students) {
                final filtered = _filterStudents(students);

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا يوجد طلاب', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) =>
                      _StudentCard(student: filtered[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
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

  List<StudentEntity> _filterStudents(List<StudentEntity> students) {
    var result = students;

    if (_searchQuery.isNotEmpty) {
      result = result.where((student) {
        final name = student.name.toLowerCase();
        final studentId = student.studentId.toLowerCase();
        return name.contains(_searchQuery.toLowerCase()) ||
            studentId.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_filterSectionId != null) {
      result = result.where((s) => s.sectionId == _filterSectionId).toList();
    }

    return result;
  }

  void _showFilterDialog(AsyncValue<List<Section>> sectionsAsync) {
    sectionsAsync.whenData((sections) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('تصفية بالشعبة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('الكل'),
                onTap: () {
                  setState(() => _filterSectionId = null);
                  Navigator.pop(ctx);
                },
              ),
              ...sections.map((section) => ListTile(
                title: Text(section.name),
                onTap: () {
                  setState(() => _filterSectionId = section.id);
                  Navigator.pop(ctx);
                },
              )),
            ],
          ),
        ),
      );
    });
  }
}

class _StudentCard extends ConsumerWidget {
  final StudentEntity student;

  const _StudentCard({required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            student.name.substring(0, 1),
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(student.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${student.studentId} • ${student.sectionName ?? student.sectionId ?? ''}'),
            if (student.phone != null)
              Text(student.phone!, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleAction(context, ref, value),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('تعديل')])),
            const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('حذف', style: TextStyle(color: Colors.red))])),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'edit':
        context.push('/students/student/edit/${student.id}');
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الطالب'),
        content: Text('هل أنت متأكد من حذف الطالب "${student.name}"؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref.read(deleteStudentUseCaseProvider)(student.id);
                ref.invalidate(studentListProvider);
                ref.invalidate(studentCountProvider);
                ref.invalidate(dashboardStatsProvider);
                UiUtils.showSnackBar(context, 'تم حذف الطالب بنجاح');
              } catch (e) {
                UiUtils.showSnackBar(context, 'خطأ: $e',
                    backgroundColor: Theme.of(context).colorScheme.error);
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
