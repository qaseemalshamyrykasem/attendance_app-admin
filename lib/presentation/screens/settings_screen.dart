/// شاشة الإعدادات
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _autoBackupEnabled = false;
  String _serverPort = '8080';
  String _language = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
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
                  secondary: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  title: const Text('الوضع الداكن'),
                  subtitle: const Text('تفعيل الوضع الداكن للتطبيق'),
                  value: _isDarkMode,
                  onChanged: (v) => setState(() => _isDarkMode = v),
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: const Text('اللغة'),
                  subtitle: Text(_language == 'ar' ? 'العربية' : 'English'),
                  trailing: DropdownButton<String>(
                    value: _language,
                    items: const [
                      DropdownMenuItem(value: 'ar', child: Text('العربية')),
                      DropdownMenuItem(value: 'en', child: Text('English')),
                    ],
                    onChanged: (v) => setState(() => _language = v!),
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
                      onChanged: (v) => setState(() => _serverPort = v),
                    ),
                  ),
                ),
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.security_outlined),
                  title: const Text('الأمان'),
                  subtitle: const Text('تغيير كلمة المرور وإعدادات البصمة'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () {},
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
                  value: _autoBackupEnabled,
                  onChanged: (v) => setState(() => _autoBackupEnabled = v),
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
                Divider(height: 1, indent: 56, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.star_border_outlined),
                  title: const Text('قيمنا على المتجر'),
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
              'نظام الحضور الذكي v1.0.0',
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
}
