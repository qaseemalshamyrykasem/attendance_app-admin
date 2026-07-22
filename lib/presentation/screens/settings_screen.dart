/// شاشة الإعدادات — حقيقية مع Riverpod (StorageService + ThemeModeProvider)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_utils.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _serverPort = '8080';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final storageService = ref.read(storageServiceProvider);
    final savedPort = storageService.getServerPort();
    if (savedPort != null) {
      _serverPort = savedPort.toString();
    }
    // Notifications setting could also come from storage
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        actions: [
          // تسجيل الخروج
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(authStateProvider.notifier).logout();
                context.go('/login');
              } else if (value == 'change_password') {
                _showChangePasswordDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'change_password', child: Row(children: [Icon(Icons.key, size: 20), SizedBox(width: 8), Text('تغيير كلمة المرور')])),
              const PopupMenuItem(value: 'logout', child: Row(children: [Icon(Icons.logout, size: 20), SizedBox(width: 8), Text('تسجيل الخروج')])),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // قسم المظهر
          _buildSectionHeader('المظهر'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  title: const Text('الوضع الداكن'),
                  subtitle: const Text('تفعيل الوضع الداكن للتطبيق'),
                  value: isDarkMode,
                  onChanged: (v) {
                    ref.read(themeModeProvider.notifier).setThemeMode(
                      v ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('تبديل الوضع'),
                  subtitle: const Text('التبديل بين الوضع الفاتح والداكن'),
                  trailing: FilledButton.tonal(
                    onPressed: () {
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                    child: const Text('تبديل'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // قسم الإشعارات
          _buildSectionHeader('الإشعارات'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications_outlined),
              title: const Text('الإشعارات'),
              subtitle: const Text('تلقي إشعارات عند تسجيل الحضور'),
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
            ),
          ),

          const SizedBox(height: 24),

          // قسم الخادم
          _buildSectionHeader('إعدادات الخادم'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings_ethernet_outlined),
                  title: const Text('رقم المنفذ الافتراضي'),
                  subtitle: const Text('المنفذ المستخدم لجلسات الحضور الجديدة'),
                  trailing: SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: _serverPort,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (v) {
                        _serverPort = v;
                        final port = int.tryParse(v);
                        if (port != null) {
                          ref.read(storageServiceProvider).setServerPort(port);
                        }
                      },
                    ),
                  ),
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.security_outlined),
                  title: const Text('الأمان'),
                  subtitle: const Text('تغيير كلمة المرور وإعدادات البصمة'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _showChangePasswordDialog(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // قسم النسخ الاحتياطي
          _buildSectionHeader('النسخ الاحتياطي'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.backup_outlined),
                  title: const Text('نسخ احتياطي تلقائي'),
                  subtitle: const Text('إنشاء نسخة احتياطية تلقائياً يومياً'),
                  value: ref.watch(storageServiceProvider).getAutoBackupEnabled() ?? false,
                  onChanged: (v) {
                    ref.read(storageServiceProvider).setAutoBackupEnabled(v);
                    setState(() {}); // Refresh UI
                  },
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.folder_outlined),
                  title: const Text('النسخ الاحتياطية'),
                  subtitle: const Text('عرض وإدارة النسخ الاحتياطية'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push('/settings/backup'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // قسم حول التطبيق
          _buildSectionHeader('حول التطبيق'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('حول التطبيق'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => context.push('/settings/about'),
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('سياسة الخصوصية'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // معلومات الإصدار
          Center(
            child: Text(
              '${AppConstants.appName} v${AppConstants.appVersion}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  void _showChangePasswordDialog() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تغيير كلمة المرور'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الحالية',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور الجديدة',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () async {
              if (newPasswordController.text != confirmPasswordController.text) {
                UiUtils.showSnackBar(context, 'كلمة المرور غير متطابقة',
                    backgroundColor: Theme.of(context).colorScheme.error);
                return;
              }

              final success = await ref.read(authStateProvider.notifier).changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              );

              Navigator.pop(ctx);

              if (success) {
                UiUtils.showSnackBar(context, 'تم تغيير كلمة المرور بنجاح');
              } else {
                UiUtils.showSnackBar(context, 'كلمة المرور الحالية غير صحيحة',
                    backgroundColor: Theme.of(context).colorScheme.error);
              }
            },
            child: const Text('تغيير'),
          ),
        ],
      ),
    );
  }
}
