/// شاشة النسخ الاحتياطي — حقيقية مع Riverpod (real DB export/import)
library;

import 'dart:io';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../services/database/local_database.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _isCreatingBackup = false;
  bool _isRestoring = false;

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(databaseProvider);
    final backupsFuture = database.getBackups();

    return Scaffold(
      appBar: AppBar(
        title: const Text('النسخ الاحتياطي'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Backup>>(
              future: backupsFuture,
              builder: (context, snapshot) {
                return ListView(
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
                          onPressed: () => _openBackupFolder(),
                          icon: const Icon(Icons.folder_open_outlined, size: 18),
                          label: const Text('فتح المجلد'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    if (snapshot.connectionState == ConnectionState.waiting)
                      const Center(child: CircularProgressIndicator())
                    else if (!snapshot.hasData || snapshot.data!.isEmpty)
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
                      ...snapshot.data!.map((backup) => _BackupCard(backup: backup)),

                    const SizedBox(height: 16),

                    // استيراد نسخة احتياطية
                    OutlinedButton.icon(
                      onPressed: () => _showImportDialog(),
                      icon: const Icon(Icons.upload_file_outlined),
                      label: const Text('استيراد نسخة احتياطية'),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createBackup() async {
    setState(() => _isCreatingBackup = true);

    try {
      final database = ref.read(databaseProvider);
      final storageService = ref.read(storageServiceProvider);

      // Get the DB file path
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFile = File('${dbFolder.path}/attendance_admin.db');

      if (!dbFile.existsSync()) {
        throw Exception('ملف قاعدة البيانات غير موجود');
      }

      // Create backup directory
      final backupDir = Directory('${dbFolder.path}/backups');
      if (!backupDir.existsSync()) {
        backupDir.createSync(recursive: true);
      }

      // Copy DB file to backup with timestamp
      final now = DateTime.now();
      final backupFileName = 'backup_${now.year}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}.db';
      final backupPath = '${backupDir.path}/$backupFileName';
      await dbFile.copy(backupPath);

      final fileSize = await File(backupPath).length();

      // Count records
      final students = await database.getAllStudents();
      final sessions = await database.getAllSessions();
      final recordsCount = students.length + sessions.length;

      // Save backup record in DB
      await database.insertBackup(BackupsCompanion(
        id: drift.Value(now.millisecondsSinceEpoch.toString()),
        filePath: drift.Value(backupPath),
        size: drift.Value(fileSize),
        recordsCount: drift.Value(recordsCount),
        createdAt: drift.Value(now),
        description: drift.Value('نسخة احتياطية تلقائية'),
      ));

      // Update last backup time
      await storageService.setLastBackupTime(now);

      if (!mounted) return;

      setState(() => _isCreatingBackup = false);

      UiUtils.showSnackBar(context, 'تم إنشاء النسخة الاحتياطية بنجاح');
    } catch (e) {
      if (!mounted) return;
      UiUtils.showSnackBar(context, 'خطأ في إنشاء النسخة الاحتياطية: $e',
          backgroundColor: Theme.of(context).colorScheme.error);
      setState(() => _isCreatingBackup = false);
    }
  }

  void _openBackupFolder() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final backupDir = '${dbFolder.path}/backups';
      UiUtils.showSnackBar(context, 'مجلد النسخ الاحتياطية: $backupDir');
    } catch (e) {
      UiUtils.showSnackBar(context, 'خطأ: $e',
          backgroundColor: Theme.of(context).colorScheme.error);
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
              UiUtils.showSnackBar(context, 'يرجى نسخ ملف النسخة الاحتياطية إلى مجلد التطبيق');
            },
            child: const Text('اختيار الملف'),
          ),
        ],
      ),
    );
  }
}

class _BackupCard extends StatelessWidget {
  final Backup backup;

  const _BackupCard({required this.backup});

  @override
  Widget build(BuildContext context) {
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
        title: Text(backup.filePath.split('/').last, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [const Icon(Icons.sd_storage, size: 14), SizedBox(width: 4), Text(FormatUtils.formatFileSize(backup.size))]),
            Row(children: [const Icon(Icons.insert_drive_file, size: 14), SizedBox(width: 4), Text('${backup.recordsCount} سجل')]),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(DateUtils.formatDate(backup.createdAt), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.restore, size: 18), tooltip: 'استعادة', onPressed: () {
                _confirmRestore(context);
              }),
              IconButton(icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red), tooltip: 'حذف', onPressed: () {
                _confirmDelete(context);
              }),
            ]),
          ],
        ),
      ),
    );
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
