/// شاشة إدارة الأقسام — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../services/database/local_database.dart';

class DepartmentManagementScreen extends ConsumerStatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  ConsumerState<DepartmentManagementScreen> createState() => _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState extends ConsumerState<DepartmentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final departmentsAsync = ref.watch(departmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأقسام'),
      ),
      body: departmentsAsync.when(
        data: (departments) {
          if (departments.isEmpty) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.business_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('لا توجد أقسام', style: TextStyle(color: Colors.grey[600])),
              ]));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: departments.length,
            itemBuilder: (context, index) =>
                _DepartmentCard(department: departments[index], onEdit: () => _editDepartment(departments[index]), onDelete: () => _deleteDepartment(departments[index])),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add_business_outlined),
        label: const Text('قسم جديد'),
      ),
    );
  }

  void _showAddDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة قسم جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم القسم *',
                prefixIcon: Icon(Icons.business_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'رمز القسم',
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
              await database.insertDepartment(DepartmentsCompanion(
                id: drift.Value(DateTime.now().millisecondsSinceEpoch.toString()),
                name: drift.Value(nameController.text.trim()),
                code: drift.Value(codeController.text.trim().isEmpty ? null : codeController.text.trim().toUpperCase()),
              ));

              Navigator.pop(ctx);
              ref.invalidate(departmentListProvider);
              ref.invalidate(dashboardStatsProvider);
              UiUtils.showSnackBar(context, 'تمت إضافة القسم بنجاح');
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDepartment(Department department) async {
    final confirm = await UiUtils.showConfirmationDialog(
      context,
      title: 'حذف القسم',
      message: 'هل أنت متأكد من حذف القسم "${department.name}"؟',
      isDestructive: true,
    );

    if (confirm) {
      final database = ref.read(databaseProvider);
      await database.deleteDepartment(department.id);
      ref.invalidate(departmentListProvider);
      ref.invalidate(dashboardStatsProvider);
      UiUtils.showSnackBar(context, 'تم حذف القسم بنجاح');
    }
  }

  void _editDepartment(Department department) {
    final nameController = TextEditingController(text: department.name);
    final codeController = TextEditingController(text: department.code ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل القسم'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم القسم *',
                prefixIcon: Icon(Icons.business_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'رمز القسم',
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
              await database.updateDepartment(Department(
                id: department.id,
                name: nameController.text.trim(),
                code: codeController.text.trim().isEmpty ? null : codeController.text.trim().toUpperCase(),
                createdAt: department.createdAt,
              ));

              Navigator.pop(ctx);
              ref.invalidate(departmentListProvider);
              UiUtils.showSnackBar(context, 'تم تحديث القسم بنجاح');
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _DepartmentCard extends StatelessWidget {
  final Department department;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DepartmentCard({required this.department, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    department.code ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit': onEdit(); break;
                      case 'delete': onDelete(); break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                    const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              department.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              AppDateUtils.formatDate(department.createdAt),
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
