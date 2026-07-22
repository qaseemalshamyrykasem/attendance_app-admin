/// شاشة إدارة الشعب
library;

import 'package:flutter/material.dart';

class SectionManagementScreen extends StatefulWidget {
  const SectionManagementScreen({super.key});

  @override
  State<SectionManagementScreen> createState() => _SectionManagementScreenState();
}

class _SectionManagementScreenState extends State<SectionManagementScreen> {
  bool _isLoading = true;
  
  // بيانات تجريبية
  List<Map<String, dynamic>> _sections = [];

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  Future<void> _loadSections() async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() {
      _sections = [
        {'id': '1', 'name': 'شعبة أ', 'levelName': 'المستوى الثالث', 'studentsCount': 35, 'departmentName': 'قسم الحاسب'},
        {'id': '2', 'name': 'شعبة ب', 'levelName': 'المستوى الثالث', 'studentsCount': 32, 'departmentName': 'قسم الحاسب'},
        {'id': '3', 'name': 'شعبة ج', 'levelName': 'المستوى الرابع', 'studentsCount': 28, 'departmentName': 'قسم الحاسب'},
        {'id': '4', 'name': 'شعبة د', 'levelName': 'المستوى الثاني', 'studentsCount': 40, 'departmentName': 'قسم الشبكات'},
        {'id': '5', 'name': 'شعبة هـ', 'levelName': 'المستوى الأول', 'studentsCount': 38, 'departmentName': 'قسم الحاسب'},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الشعب'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sections.isEmpty
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.group_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('لا توجد شعب', style: TextStyle(color: Colors.grey[600])),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _sections.length,
                  itemBuilder: (context, index) => _SectionCard(section: _sections[index]),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add),
        label: const Text('شعبة جديدة'),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة شعبة جديدة'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'اسم الشعبة *',
                  prefixIcon: Icon(Icons.group_add_outlined),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'المستوى',
                  prefixIcon: Icon(Icons.layers_outlined),
                ),
                items: [
                  DropdownMenuItem(value: '1', child: Text('المستوى الأول')),
                  DropdownMenuItem(value: '2', child: Text('المستوى الثاني')),
                  DropdownMenuItem(value: '3', child: Text('المستوى الثالث')),
                  DropdownMenuItem(value: '4', child: Text('المستوى الرابع')),
                ],
                onChanged: (v) {},
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
                const SnackBar(content: Text('تمت إضافة الشعبة بنجاح')),
              );
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Map<String, dynamic> section;

  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
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
              section['name']?.toString().substring(0, 2) ?? '',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        title: Text(section['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const Icon(Icons.layers_outlined, size: 14), SizedBox(width: 4), Text('${section['levelName']}')]),
            Row(children: [const Icon(Icons.business_outlined, size: 14), SizedBox(width: 4), Text('${section['departmentName']}')]),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${section['studentsCount']}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text('طالب', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
        onTap: () {
          // عرض تفاصيل الشعبة
        },
      ),
    );
  }
}
