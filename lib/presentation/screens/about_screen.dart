/// شاشة حول التطبيق
library;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حول التطبيق'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // شعار التطبيق
          Center(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.how_to_reg_rounded, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  'نظام الحضور الذكي',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'لوحة التحكم - الإصدار 1.0.0',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // معلومات التطبيق
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.info_outline,
                  label: 'اسم التطبيق',
                  value: 'نظام الحضور الذكي - لوحة الإدارة',
                ),
                Divider(indent: 56, endIndent: 16),
                _InfoTile(
                  icon: Icons.apps_outlined,
                  label: 'الإصدار',
                  value: '1.0.0 (Build 1)',
                ),
                Divider(indent: 56, endIndent: 16),
                _InfoTile(
                  icon: Icons.inventory_2_outlined,
                  label: 'الحزمة',
                  value: 'com.attendance.admin',
                ),
                Divider(indent: 56, endIndent: 16),
                _InfoTile(
                  icon: Icons.code_outlined,
                  label: 'إطار العمل',
                  value: 'Flutter 3.x',
                ),
                Divider(indent: 56, endIndent: 16),
                _InfoTile(
                  icon: Icons.storage_outlined,
                  label: 'قاعدة البيانات',
                  value: 'SQLite (Drift ORM)',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // المميزات
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Icon(Icons.star, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8), Text('المميزات الرئيسية', style: TextStyle(fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 16),
                  _FeatureItem(icon: Icons.qr_code_scanner, title: 'مسح QR Code لتسجيل الحضور'),
                  _FeatureItem(icon: Icons.dns, title: 'خادم محلي للجلسات النشطة'),
                  _FeatureItem(icon: Icons.bar_chart, title: 'تقارير وإحصائيات مفصلة'),
                  _FeatureItem(icon: Icons.backup, title: 'نسخ احتياطي واستعادة البيانات'),
                  _FeatureItem(icon: Icons.upload_file_outlined, title: 'تصدير تقارير Excel و PDF'),
                  _FeatureItem(icon: Icons.security, title: 'تشفير وحماية البيانات'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // روابط مفيدة
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.description_outlined, color: Theme.of(context).colorScheme.primary),
                  title: const Text('سياسة الخصوصية'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _launchUrl('https://example.com/privacy'),
                ),
                Divider(indent: 56, endIndent: 16),
                ListTile(
                  leading: Icon(Icons.article_outlined, color: Theme.of(context).colorScheme.primary),
                  title: const Text('شروط الاستخدام'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _launchUrl('https://example.com/terms'),
                ),
                Divider(indent: 56, endIndent: 16),
                ListTile(
                  leading: Icon(Icons.support_agent_outlined, color: Theme.of(context).colorScheme.primary),
                  title: const Text('الدعم الفني'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _launchUrl('https://example.com/support'),
                ),
                Divider(indent: 56, endIndent: 16),
                ListTile(
                  leading: Icon(Icons.star_rate_outlined, color: Theme.of(context).colorScheme.primary),
                  title: const Text('قيمنا على المتجر'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => _launchUrl('https://example.com/rate'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // حقوق النشر
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('© ${DateTime.now().year} نظام الحضور الذكي', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 8),
                  Text('جميع الحقوق محفوظة', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  const SizedBox(height: 8),
                  Text('تم التطوير بـ ❤️', style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// ============================================
// Widgets فرعية
// ============================================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, size: 20, color: Colors.grey[600]),
      title: Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      subtitle: null,
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface))),
        ],
      ),
    );
  }
}
