/// شاشة إنشاء جلسة جديدة — حقيقية مع Riverpod
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_utils.dart';
import '../../services/database/local_database.dart';

class SessionCreateScreen extends ConsumerStatefulWidget {
  const SessionCreateScreen({super.key});

  @override
  ConsumerState<SessionCreateScreen> createState() => _SessionCreateScreenState();
}

class _SessionCreateScreenState extends ConsumerState<SessionCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCourseId;
  String? _selectedSectionId;
  int _port = 8080;
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(courseListProvider);
    final sectionsAsync = ref.watch(sectionListProvider);
    final storageService = ref.watch(storageServiceProvider);

    // Load default port from storage
    final savedPort = storageService.getServerPort();
    if (savedPort != null && _port == 8080) {
      _port = savedPort;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء جلسة جديدة'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // اختيار المقرر
            coursesAsync.when(
              data: (courses) => _buildCourseSelector(courses),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ في تحميل المقررات: $e')),
            ),

            const SizedBox(height: 16),

            // اختيار الشعبة
            sectionsAsync.when(
              data: (sections) => _buildSectionSelector(sections),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ في تحميل الشعب: $e')),
            ),

            const SizedBox(height: 16),

            // إعدادات الخادم
            _buildServerSettings(),

            const SizedBox(height: 32),

            // أزرار الإجراءات
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSelector(List<Course> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المقرر',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCourseId,
          decoration: InputDecoration(
            hintText: 'اختر المقرر',
            prefixIcon: const Icon(Icons.book_outlined),
          ),
          items: courses.map((course) {
            return DropdownMenuItem(
              value: course.id,
              child: Text('${course.name} (${course.code ?? ''})'),
            );
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى اختيار المقرر';
            }
            return null;
          },
          onChanged: (value) {
            setState(() => _selectedCourseId = value);
          },
        ),
      ],
    );
  }

  Widget _buildSectionSelector(List<Section> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الشعبة',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedSectionId,
          decoration: InputDecoration(
            hintText: 'اختر الشعبة',
            prefixIcon: const Icon(Icons.group_outlined),
          ),
          items: sections.map((section) {
            return DropdownMenuItem(
              value: section.id,
              child: Text(section.name),
            );
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى اختيار الشعبة';
            }
            return null;
          },
          onChanged: (value) {
            setState(() => _selectedSectionId = value);
          },
        ),
      ],
    );
  }

  Widget _buildServerSettings() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.dns_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'إعدادات الخادم',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextFormField(
              initialValue: _port.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'رقم المنفذ (Port)',
                hintText: '8080',
                prefixIcon: const Icon(Icons.settings_ethernet_outlined),
                helperText: 'سيستخدم الطلاب هذا الرقم للاتصال',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال رقم المنفذ';
                }
                final port = int.tryParse(value);
                if (port == null || port < 1024 || port > 65535) {
                  return 'رقم المنفذ يجب أن يكون بين 1024 و 65535';
                }
                return null;
              },
              onChanged: (value) {
                _port = int.tryParse(value) ?? 8080;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        FilledButton.icon(
          onPressed: _isCreating ? null : _createAndStartSession,
          icon: _isCreating
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.play_arrow_rounded),
          label: Text(
            _isCreating ? 'جارٍ الإنشاء...' : 'إنشاء وبدء الجلسة',
            style: const TextStyle(fontSize: 16),
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
          label: const Text('رجوع'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _createAndStartSession() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCourseId == null || _selectedSectionId == null) {
      UiUtils.showSnackBar(context, 'يرجى اختيار المقرر والشعبة');
      return;
    }

    setState(() => _isCreating = true);

    try {
      // Save port preference
      await ref.read(storageServiceProvider).setServerPort(_port);

      // Create and start the session via the notifier
      final data = await ref.read(activeSessionProvider.notifier).createAndStartSession(
        courseId: _selectedCourseId!,
        sectionId: _selectedSectionId!,
        customPort: _port,
      );

      if (!mounted) return;

      // Invalidate related providers to refresh data
      ref.invalidate(sessionListProvider);
      ref.invalidate(activeSessionListProvider);
      ref.invalidate(dashboardStatsProvider);

      UiUtils.showSnackBar(context, 'تم إنشاء الجلسة بنجاح');

      // Navigate to active session screen
      context.go('/dashboard/session/active');
    } catch (e) {
      if (!mounted) return;
      UiUtils.showSnackBar(context, 'خطأ في إنشاء الجلسة: $e',
          backgroundColor: Theme.of(context).colorScheme.error);
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }
}
