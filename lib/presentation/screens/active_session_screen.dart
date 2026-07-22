/// شاشة الجلسة النشطة
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isRunning = true;
  int _connectedCount = 0;
  int _attendanceCount = 0;
  
  // بيانات تجريبية
  final List<Map<String, dynamic>> _recentCheckIns = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // محاكاة وصول حضور جديد كل فترة
    _simulateCheckIns();
  }

  void _simulateCheckIns() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted || !_isRunning) return;
      
      setState(() {
        _connectedCount++;
        _attendanceCount++;
        _recentCheckIns.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'studentId': 'STU${(_attendanceCount).toString().padLeft(4, '0')}',
          'name': 'طالب $_attendanceCount',
          'time': DateTime.now(),
        });
        
        // الاحتفاظ بآخر 10 سجلات فقط
        if (_recentCheckIns.length > 10) {
          _recentCheckIns.removeLast();
        }
      });
      
      _simulateCheckIns();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسة نشطة'),
        actions: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1 + (_pulseController.value * 0.1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'مباشر',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // معلومات الجلسة
                _buildSessionInfoCard(),

                const SizedBox(height: 24),

                // QR Code
                _buildQRCodeSection(),

                const SizedBox(height: 24),

                // الإحصائيات المباشرة
                _buildLiveStats(),

                const SizedBox(height: 24),

                // آخر تسجيلات الحضور
                _buildRecentCheckIns(),
              ],
            ),
          ),

          // زر إغلاق الجلسة
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildSessionInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'برمجة متقدمة',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'شعبة أ • ${_formatDate(DateTime.now())}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.dns, size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '192.168.1.100:8080',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy_outlined, size: 18),
                  onPressed: () {
                    // نسخ العنوان
                  },
                  tooltip: 'نسخ العنوان',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'امسح رمز QR للتسجيل',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // QR Code Placeholder - في الإنتاج استخدم qr_flutter package
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_2, size: 80, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('رمز QR', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.fullscreen_outlined),
              label: const Text('عرض بحجم كامل'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveStats() {
    return Row(
      children: [
        Expanded(
          child: _LiveStatCard(
            title: 'المتصلون',
            value: '$_connectedCount',
            icon: Icons.people_outline,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _LiveStatCard(
            title: 'الحاضرون',
            value: '$_attendanceCount',
            icon: Icons.check_circle_outline,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCheckIns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'آخر التسجيلات',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (_recentCheckIns.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.hourglass_empty, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  'في انتظار تسجيل الحضور...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          )
        else
          ..._recentCheckIns.map((checkIn) => _RecentCheckInCard(checkIn: checkIn)),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: FilledButton.tonalIcon(
        onPressed: _showCloseConfirmation,
        icon: const Icon(Icons.stop_circle_outlined),
        label: const Text('إغلاق الجلسة'),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.1),
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Future<void> _showCloseConfirmation() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إغلاق الجلسة'),
        content: const Text('هل أنت متأكد من إغلاق هذه الجلسة؟\nلن يتمكن الطلاب من تسجيل الحضور بعد الإغلاق.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      setState(() => _isRunning = false);
      // الانتقال لصفحة تفاصيل الجلسة
      context.go('/dashboard/session/1');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// ============================================
// Widgets فرعية
// ============================================

class _LiveStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _LiveStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              )),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _RecentCheckInCard extends StatelessWidget {
  final Map<String, dynamic> checkIn;

  const _RecentCheckInCard({required this.checkIn});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.green.withOpacity(0.1),
          child: const Icon(Icons.check, color: Colors.green, size: 18),
        ),
        title: Text(checkIn['name'] ?? ''),
        subtitle: Text(checkIn['studentId'] ?? ''),
        trailing: Text(
          _formatTime(checkIn['time']),
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ),
    );
  }

  String _formatTime(dynamic time) {
    if (time is DateTime) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '';
  }
}
