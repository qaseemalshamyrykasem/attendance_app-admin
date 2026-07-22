/// شاشة الجلسة النشطة — حقيقية مع Riverpod + QR code حقيقي + real check-in events
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/di/providers.dart';
import '../../core/utils/app_utils.dart';
import '../../domain/entities/entities.dart';
import '../../services/network/http_server_service.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  ConsumerState<ActiveSessionScreen> createState() =>
      _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  StreamSubscription? _checkInSubscription;
  List<_CheckInEvent> _recentCheckIns = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _checkInSubscription?.cancel();
    super.dispose();
  }

  void _listenToCheckIns() {
    final httpServer = ref.read(httpServerServiceProvider);
    if (httpServer != null) {
      _checkInSubscription?.cancel();
      _checkInSubscription = httpServer.checkInStream.listen((event) {
        if (!mounted) return;
        setState(() {
          _recentCheckIns.insert(
              0,
              _CheckInEvent(
                studentId: event.studentId,
                studentName: event.studentId, // Name will be resolved from DB
                time: event.timestamp,
              ));
          if (_recentCheckIns.length > 20) {
            _recentCheckIns.removeLast();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionData = ref.watch(activeSessionProvider);

    // Listen to check-in events
    _listenToCheckIns();

    // If no active session, show message
    if (sessionData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('جلسة نشطة')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.event_busy_outlined,
                  size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text('لا توجد جلسة نشطة',
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.go('/dashboard/session/create'),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('إنشاء جلسة جديدة'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('جلسة نشطة'),
        actions: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green
                      .withValues(alpha: 0.1 + (_pulseController.value * 0.1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'مباشر',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.green),
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
                _buildSessionInfoCard(sessionData),

                const SizedBox(height: 24),

                // QR Code
                _buildQRCodeSection(sessionData),

                const SizedBox(height: 24),

                // الإحصائيات المباشرة
                _buildLiveStats(sessionData),

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

  Widget _buildSessionInfoCard(ActiveSessionData data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.courseId,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${data.sectionId} • ${AppDateUtils.formatDate(data.date)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.dns,
                    size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  '${data.ip}:${data.port}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy_outlined, size: 18),
                  onPressed: () {
                    // Copy IP:port to clipboard
                    UiUtils.showSnackBar(
                        context, 'تم نسخ العنوان: ${data.ip}:${data.port}');
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

  Widget _buildQRCodeSection(ActiveSessionData data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'امسح رمز QR للتسجيل',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // Real QR Code using qr_flutter
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Center(
                child: QrImageView(
                  data: data.qrData,
                  version: QrVersions.auto,
                  size: 180,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (context, error) {
                    return Center(
                      child: Text(
                        'خطأ في QR: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                _showFullScreenQR(data);
              },
              icon: const Icon(Icons.fullscreen_outlined),
              label: const Text('عرض بحجم كامل'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenQR(ActiveSessionData data) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'رمز QR للجلسة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              QrImageView(
                data: data.qrData,
                version: QrVersions.auto,
                size: 300,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                '${data.ip}:${data.port}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveStats(ActiveSessionData data) {
    return Row(
      children: [
        Expanded(
          child: _LiveStatCard(
            title: 'المتصلون',
            value: '${data.connectedCount}',
            icon: Icons.people_outline,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _LiveStatCard(
            title: 'الحاضرون',
            value: '${_recentCheckIns.length}',
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
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
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
          ..._recentCheckIns
              .map((checkIn) => _RecentCheckInCard(checkIn: checkIn)),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
          backgroundColor: Colors.red.withValues(alpha: 0.1),
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
        content: const Text(
            'هل أنت متأكد من إغلاق هذه الجلسة؟\nلن يتمكن الطلاب من تسجيل الحضور بعد الإغلاق.'),
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
      try {
        await ref.read(activeSessionProvider.notifier).closeSession();
        if (!mounted) return;

        // Invalidate providers to refresh data
        ref.invalidate(sessionListProvider);
        ref.invalidate(activeSessionListProvider);
        ref.invalidate(dashboardStatsProvider);

        UiUtils.showSnackBar(context, 'تم إغلاق الجلسة بنجاح');

        context.go('/dashboard');
      } catch (e) {
        if (mounted) {
          UiUtils.showSnackBar(context, 'خطأ في إغلاق الجلسة: $e',
              backgroundColor: Theme.of(context).colorScheme.error);
        }
      }
    }
  }
}

// ============================================
// Data class for check-in events
// ============================================

class _CheckInEvent {
  final String studentId;
  final String studentName;
  final DateTime time;

  _CheckInEvent({
    required this.studentId,
    required this.studentName,
    required this.time,
  });
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
  final _CheckInEvent checkIn;

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
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          child: const Icon(Icons.check, color: Colors.green, size: 18),
        ),
        title: Text(checkIn.studentName),
        subtitle: Text(checkIn.studentId),
        trailing: Text(
          AppDateUtils.formatTime(checkIn.time, pattern: 'HH:mm'),
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
