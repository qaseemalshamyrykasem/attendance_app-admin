/// شاشة إدارة الأقسام
library;

import 'package:flutter/material.dart';

class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  State<DepartmentManagementScreen> createState() => _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState extends State<DepartmentManagementScreen> {
  bool _isLoading = true;
  
  // بيانات تجريبية
  List<Map<String, dynamic>> _departments = [];

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() {
      _departments = [
        {'id': '1', 'name': 'قسم علوم الحاسب', 'code': 'CS', 'studentsCount': 150, 'sectionsCount': 5},
        {'id': '2', 'name': 'قسم هندسة البرمجيات', 'code': 'SE', 'studentsCount': 85, 'sectionsCount': 3},
        {'id': '3', 'name': 'قسم الشبكات', 'code': 'NET', 'studentsCount': 62, 'sectionsCount': 2},
        {'id': '4', 'name': 'قسم الذكاء الاصطناعي', 'code': 'AI', 'studentsCount': 45, 'sectionsCount': 2},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأقسام'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _departments.isEmpty
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.business_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('لا توجد أقسام', style: TextStyle(color: Colors.grey[600])),
                ]))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _departments.length,
                  itemBuilder: (context, index) => _DepartmentCard(department: _departments[index]),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add_business_outlined),
        label: const Text('قسم جديد'),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة قسم جديد'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'اسم القسم *',
                  prefixIcon: Icon(Icons.business_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'رمز القسم',
                  prefixIcon: Icon(Icons.code_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تمت إضافة القسم بنجاح')),
              );
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _DepartmentCard extends StatelessWidget {
  final Map<String, dynamic> department;

  const _DepartmentCard({required this.department});

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
                    department['code'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                    const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              department['name'] ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(icon: Icons.people_outline, value: '${department['studentsCount']}', label: 'طالب'),
                _StatItem(icon: Icons.group_work_outlined, value: '${department['sectionsCount']}', label: 'شعبة'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}
