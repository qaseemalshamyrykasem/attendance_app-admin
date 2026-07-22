/// شاشة إنشاء جلسة جديدة
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionCreateScreen extends StatefulWidget {
  const SessionCreateScreen({super.key});

  @override
  State<SessionCreateScreen> createState() => _SessionCreateScreenState();
}

class _SessionCreateScreenState extends State<SessionCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedCourseId;
  String? _selectedSectionId;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay? _endTime;
  int _port = 8080;
  bool _isLoading = false;
  bool _isCreating = false;

  // بيانات تجريبية - ستُستبدل بالبيانات الحقيقية
  final List<Map<String, dynamic>> _courses = [
    {'id': '1', 'name': 'برمجة متقدمة', 'code': 'CS401'},
    {'id': '2', 'name': 'قواعد بيانات', 'code': 'CS302'},
    {'id': '3', 'name': 'ذكاء اصطناعي', 'code': 'CS405'},
    {'id': '4', 'name': 'شبكات الحاسوب', 'code': 'CS303'},
    {'id': '5', 'name': 'هندسة البرمجيات', 'code': 'CS402'},
  ];

  final List<Map<String, dynamic>> _sections = [
    {'id': '1', 'name': 'شعبة أ'},
    {'id': '2', 'name': 'شعبة ب'},
    {'id': '3', 'name': 'شعبة ج'},
    {'id': '4', 'name': 'شعبة د'},
    {'id': '5', 'name': 'شعبة هـ'},
  ];

  @override
  Widget build(BuildContext context) {
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
            _buildCourseSelector(),

            const SizedBox(height: 16),

            // اختيار الشعبة
            _buildSectionSelector(),

            const SizedBox(height: 16),

            // اختيار التاريخ والوقت
            _buildDateTimeSection(),

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

  Widget _buildCourseSelector() {
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
          items: _courses.map((course) {
            return DropdownMenuItem(
              value: course['id'] as String,
              child: Text('${course['name']} (${course['code']})'),
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

  Widget _buildSectionSelector() {
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
          items: _sections.map((section) {
            return DropdownMenuItem(
              value: section['id'] as String,
              child: Text(section['name'] as String),
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

  Widget _buildDateTimeSection() {
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
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'التاريخ والوقت',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // التاريخ
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _formatDate(_selectedDate),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // وقت البدء
            InkWell(
              onTap: _selectStartTime,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _formatTime(_startTime),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    const Text('بداية الجلسة'),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // وقت النهاية (اختياري)
            InkWell(
              onTap: _selectEndTime,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _endTime != null ? _formatTime(_endTime!) : 'غير محدد',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: _endTime == null
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4)
                                : null,
                          ),
                    ),
                    const Spacer(),
                    const Text('نهاية الجلسة (اختياري)'),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  // ============================================
  // Methods
  // ============================================

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? ColorScheme.dark(primary: Colors.green)
                : ColorScheme.light(primary: Colors.green),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? ColorScheme.dark(primary: Colors.green)
                : ColorScheme.light(primary: Colors.green),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() => _startTime = time);
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _endTime ?? _startTime.replacing(hour: _startTime.hour + 2),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? ColorScheme.dark(primary: Colors.green)
                : ColorScheme.light(primary: Colors.green),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() => _endTime = time);
    }
  }

  Future<void> _createAndStartSession() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCreating = true);

    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة الإنشاء

      if (!mounted) return;

      // الانتقال لشاشة الجلسة النشطة
      context.go('/dashboard/session/active');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ في إنشاء الجلسة: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
