/// شاشة النسخ الاحتياطي
library;

import 'package:flutter/material.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _isCreatingBackup = false;
  bool _isRestoring = false;

  // بيانات تجريبية
  final List<Map<String, dynamic>> _backups = [
    {
      'id': '1',
      'fileName': 'backup_2024_01_15.db',
      'size': '2.4 MB',
      'recordsCount': 156,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'fileName': 'backup_2024_01_10.db',
      'size': '2.3 MB',
      'recordsCount': 148,
      'createdAt': DateTime.now().subtract(const Duration(days: 7)),
    },
    {
      'id': '3',
      'fileName': 'backup_2024_01_05.db',
      'size': '2.1 MB',
      'recordsCount': 135,
      'createdAt': DateTime.now().subtract(const Duration(days: 12)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النسخ الاحتياطي'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // بطاقة إنشاء نسخة احتياطية
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(Icons.backup_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 16),
                        Text(
                          'حماية بياناتك',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'قم بإنشاء نسخة احتياطية من بياناتك بشكل دوري لتجنب فقدان البيانات',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: _isCreatingBackup ? null : _createBackup,
                          icon: _isCreatingBackup
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.add_circle_outline),
                          label: Text(_isCreatingBackup ? 'جارٍ الإنشاء...' : 'إنشاء نسخة احتياطية'),
                          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // قائمة النسخ الاحتياطية السابقة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('النسخ الاحتياطية السابقة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.folder_open_outlined, size: 18),
                      label: const Text('فتح المجلد'),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (_backups.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text('لا توجد نسخ احتياطية', style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(height: 8),
                          Text('أنشئ أول نسخة احتياطية الآن', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                        ],
                      ),
                    ),
                  )
                else
                  ..._backups.map((backup) => _BackupCard(backup: backup)),

                const SizedBox(height: 16),

                // استيراد نسخة احتياطية
                OutlinedButton.icon(
                  onPressed: () => _showImportDialog(),
                  icon: const Icon(Icons.upload_file_outlined),
                  label: const Text('استيراد نسخة احتياطية'),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createBackup() async {
    setState(() => _isCreatingBackup = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _backups.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'fileName': 'backup_${DateTime.now().year}_${DateTime.now().month.toString().padLeft(2, '0')}_${DateTime.now().day.toString().padLeft(2, '0')}.db',
          'size': '${(2.5 + (_backups.length * 0.1)).toStringAsFixed(1)} MB',
          'recordsCount': 156 + _backups.length,
          'createdAt': DateTime.now(),
        });
        _isCreatingBackup = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء النسخة الاحتياطية بنجاح')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في إنشاء النسخة الاحتياطية: $e'), backgroundColor: Theme.of(context).colorScheme.error),
      );
      setState(() => _isCreatingBackup = false);
    }
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('استيراد نسخة احتياطية'),
        content: const Text('اختر ملف النسخة الاحتياطية لاستعادة البيانات منه. سيتم استبدال جميع البيانات الحالية.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _restoreBackup();
            },
            child: const Text('اختيار الملف'),
          ),
        ],
      ),
    );
  }

  Future<void> _restoreBackup() async {
    setState(() => _isRestoring = true);

    try {
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم استعادة النسخة الاحتياطية بنجاح')),
      );

      setState(() => _isRestoring = false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في الاستعادة: $e'), backgroundColor: Theme.of(context).colorScheme.error),
      );
      setState(() => _isRestoring = false);
    }
  }
}

// ============================================
// Widgets فرعية
// ============================================

class _BackupCard extends StatelessWidget {
  final Map<String, dynamic> backup;

  const _BackupCard({required this.backup});

  @override
  Widget build(BuildContext context) {
    final createdAt = backup['createdAt'] as DateTime;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.storage_outlined, color: Colors.blue),
        ),
        title: Text(backup['fileName'] ?? '', style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const Icon(Icons.sd_storage, size: 14), SizedBox(width: 4), Text('${backup['size']}')]),
            Row(children: [const Icon(Icons.insert_drive_file, size: 14), SizedBox(width: 4), Text('${backup['recordsCount']} سجل')]),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(_formatDate(createdAt), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.restore, size: 18), tooltip: 'استعادة', onPressed: () => _confirmRestore(context)),
              IconButton(icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red), tooltip: 'حذف', onPressed: () => _confirmDelete(context)),
            ]),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) return 'اليوم';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} أيام';
    if (diff.inDays < 30) return 'منذ ${(diff.inDays / 7).floor()} أسبوع';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _confirmRestore(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('استعادة النسخة الاحتياطية'),
        content: const Text('سيتم استبدال جميع البيانات الحالية بالبيانات من هذه النسخة. هل تريد المتابعة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('استعادة'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف النسخة الاحتياطية'),
        content: const Text('هل أنت متأكد من حذف هذه النسخة الاحتياطية؟ لا يمكن التراجع عن هذا الإجراء.'),
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
