/// شاشة التقارير
library;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'ملخص'),
            Tab(text: 'الحضور'),
            Tab(text: 'المقررات'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SummaryTab(),
          _AttendanceTab(),
          _CoursesTab(),
        ],
      ),
    );
  }
}

// ============================================
// تبويب الملخص
// ============================================

class _SummaryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // بطاقات الإحصائيات الرئيسية
        Row(
          children: [
            Expanded(child: _SummaryCard(title: 'إجمالي الطلاب', value: '156', icon: Icons.people, color: Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _SummaryCard(title: 'معدل الحضور', value: '87.5%', icon: Icons.trending_up, color: Colors.green)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _SummaryCard(title: 'جلسات هذا الشهر', value: '24', icon: Icons.event, color: Colors.orange)),
            const SizedBox(width: 12),
            Expanded(child: _SummaryCard(title: 'المقررات النشطة', value: '8', icon: Icons.book, color: Colors.purple)),
          ],
        ),

        const SizedBox(height: 24),

        // رسم بياني للحضور الشهري
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('معدل الحضور الشهري', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                          const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو'];
                          if (value.toInt() < months.length) return Text(months[value.toInt()], style: const TextStyle(fontSize: 10));
                          return Text('');
                        })),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: true, drawVerticalLine: false),
                      barGroups: [
                        _makeBarGroup(0, 85, Colors.green),
                        _makeBarGroup(1, 88, Colors.green),
                        _makeBarGroup(2, 82, Colors.orange),
                        _makeBarGroup(3, 90, Colors.green),
                        _makeBarGroup(4, 87, Colors.green),
                        _makeBarGroup(5, 91, Colors.green),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, Color color) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: color, width: 20, borderRadius: BorderRadius.circular(4)),
    ]);
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({required this.title, required this.value, required this.icon, required this.color});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

// ============================================
// تبويب الحضور
// ============================================

class _AttendanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // فلاتر التاريخ
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                const Text('اختر الفترة'),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.date_range, size: 18),
                  label: const Text('هذا الشهر'),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // إحصائيات الحضور
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إحصائيات الحضور', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _AttendanceStatItem(color: Colors.green, label: 'حاضر', count: 1365, percentage: 85),
                    _AttendanceStatItem(color: Colors.red, label: 'غائب', count: 168, percentage: 10.5),
                    _AttendanceStatItem(color: Colors.orange, label: 'متأخر', count: 67, percentage: 4.2),
                    _AttendanceStatItem(color: Colors.blue, label: 'معذور', count: 5, percentage: 0.3),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // قائمة أيام الحضور
        ...List.generate(7, (index) => _DayAttendanceCard(date: DateTime.now().subtract(Duration(days: index)))),
      ],
    );
  }
}

class _AttendanceStatItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  final double percentage;

  const _AttendanceStatItem({required this.color, required this.label, required this.count, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Center(child: Text('$count', style: TextStyle(fontWeight: FontWeight.bold, color: color))),
        ),
        const SizedBox(height: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text('$percentage%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}

class _DayAttendanceCard extends StatelessWidget {
  final DateTime date;

  const _DayAttendanceCard({required this.date});

  @override
  Widget build(BuildContext context) {
    final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isToday ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${date.day}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isToday ? Colors.white : null)),
              Text(_getMonthName(date.month), style: TextStyle(fontSize: 9, color: isToday ? Colors.white70 : Colors.grey[600])),
            ],
          ),
        ),
        title: Text(isToday ? 'اليوم' : _formatDate(date)),
        subtitle: Text('28 حاضر • 2 غائب • 1 متأخر'),
        trailing: FilledButton.tonal(
          onPressed: () {},
          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12), minimumSize: Size(0, 32)),
          child: const Text('تفاصيل', style: TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return months[(month - 1) % 12];
  }

  String _formatDate(DateTime date) => '${date.day} ${_getMonthName(date.month)}';
}

// ============================================
// تبويب المقررات
// ============================================

class _CoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // بيانات تجريبية للمقررات
        ...List.generate(5, (index) => _CourseReportCard(index: index + 1)),
      ],
    );
  }
}

class _CourseReportCard extends StatelessWidget {
  final int index;

  const _CourseReportCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final courses = ['برمجة متقدمة', 'قواعد بيانات', 'ذكاء اصطناعي', 'شبكات الحاسوب', 'هندسة البرمجيات'];
    final attendanceRates = [92, 88, 95, 78, 89];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(courses[index - 1], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text('${attendanceRates[index - 1]}%', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: attendanceRates[index - 1] >= 90 ? Colors.green : (attendanceRates[index - 1] >= 80 ? Colors.orange : Colors.red),
                )),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: attendanceRates[index - 1] / 100,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  attendanceRates[index - 1] >= 90 ? Colors.green : (attendanceRates[index - 1] >= 80 ? Colors.orange : Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MiniStat(icon: Icons.check_circle, value: '${28 - index}', color: Colors.green),
                _MiniStat(icon: Icons.cancel, value: '$index', color: Colors.red),
                _MiniStat(icon: Icons.schedule, value: index > 0 ? '2' : '0', color: Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _MiniStat({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 14, color: color), const SizedBox(width: 4), Text(value)]);
  }
}
