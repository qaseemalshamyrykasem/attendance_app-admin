/// الشاشة الرئيسية مع شريط التنقل السفلي
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() => _currentIndex = index);
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false, // منع الرجوع للخروج من التطبيق
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        // يمكن إضافة حوار تأكيد للخروج هنا
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onDestinationSelected,
          backgroundColor: colorScheme.surface,
          elevation: 8,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people_rounded),
              label: 'الطلاب',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school_rounded),
              label: 'المناهج',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart_rounded),
              label: 'التقارير',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings_rounded),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}
