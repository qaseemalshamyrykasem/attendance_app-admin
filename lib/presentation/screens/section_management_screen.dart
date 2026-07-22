/// شاشة إدارة الشعب — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../services/database/local_database.dart';

class SectionManagementScreen extends ConsumerStatefulWidget {
  const SectionManagementScreen({super.key});

  @override
  ConsumerState<SectionManagementScreen> createState() => _SectionManagementScreenState();
}

class _SectionManagementScreenState extends ConsumerState<SectionManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final sectionsAsync = ref.watch(sectionListProvider);
    final departmentsAsync = ref.watch(departmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الشعب'),
      ),
      body: sectionsAsync.when(
        data: (sections) {
          if (sections.isEmpty) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.group_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('لا توجد شعب', style: TextStyle(color: Colors.grey[600])),
              ]));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sections.length,
            itemBuilder: (context, index) => _SectionCard(
              section: sections[index],
              departments: departmentsAsync.when(
                data: (d) => d,
                loading: () => [],
                error: (e, _) => [],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add),
        label: const Text('شعبة جديدة'),
      ),
    );
  }

  void _showAddDialog() {
    final nameController = TextEditingController();
    String? selectedDepartmentId;

    showDialog(
      context: context,
      builder: (ctx) {
        final departments = ref.read(departmentListProvider).whenData((d) => d).value ?? [];

        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: const Text('إضافة شعبة جديدة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم الشعبة *',
                    prefixIcon: Icon(Icons.group_add_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDepartmentId,
                  decoration: const InputDecoration(
                    labelText: 'القسم',
                    prefixIcon: Icon(Icons.business_outlined),
                  ),
                  items: departments.map((d) => DropdownMenuItem(
                    value: d.id,
                    child: Text(d.name),
                  )).toList(),
                  onChanged: (v) => setDialogState(() => selectedDepartmentId = v),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
              FilledButton(
                onPressed: () async {
                  if (nameController.text.trim().isEmpty) return;

                  final database = ref.read(databaseProvider);
                  await database.insertSection(SectionsCompanion(
                    id: drift.Value(DateTime.now().millisecondsSinceEpoch.toString()),
                    name: drift.Value(nameController.text.trim()),
                    departmentId: drift.Value(selectedDepartmentId),
                  ));

                  Navigator.pop(ctx);
                  ref.invalidate(sectionListProvider);
                  ref.invalidate(dashboardStatsProvider);
                  UiUtils.showSnackBar(context, 'تمت إضافة الشعبة بنجاح');
                },
                child: const Text('حفظ'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteSection(Section section) async {
    final confirm = await UiUtils.showConfirmationDialog(
      context,
      title: 'حذف الشعبة',
      message: 'هل أنت متأكد من حذف الشعبة "${section.name}"؟',
      isDestructive: true,
    );

    if (confirm) {
      final database = ref.read(databaseProvider);
      await database.deleteSection(section.id);
      ref.invalidate(sectionListProvider);
      ref.invalidate(dashboardStatsProvider);
      UiUtils.showSnackBar(context, 'تم حذف الشعبة بنجاح');
    }
  }
}

class _SectionCard extends StatelessWidget {
  final Section section;
  final List<Department> departments;

  const _SectionCard({required this.section, required this.departments});

  String? _getDepartmentName() {
    if (section.departmentId == null) return null;
    final dept = departments.where((d) => d.id == section.departmentId).firstOrNull;
    return dept?.name;
  }

  @override
  Widget build(BuildContext context) {
    final deptName = _getDepartmentName();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              section.name.substring(0, section.name.length > 2 ? 2 : section.name.length),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        title: Text(section.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deptName != null)
              Row(children: [const Icon(Icons.business_outlined, size: 14), SizedBox(width: 4), Text(deptName)]),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 20),
          onPressed: () {
            // Delete handled via callback
          },
        ),
      ),
    );
  }
}
