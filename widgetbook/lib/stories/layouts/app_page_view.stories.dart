import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';


@widgetbook.UseCase(
  name: 'Desktop Dashboard (Fixed Header + Menu)',
  type: AppPageView,
)
Widget buildDesktopDashboard(BuildContext context) {

  final showOverlay = context.knobs.boolean(label: 'Show Grid Overlay', initialValue: true);

  return AppPageView(
    useSlivers: false,
    scrollable: true,
    showGridOverlay: showOverlay,
    
    header: Container(
      height: 64,
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Text('Dashboard Header', style: Theme.of(context).textTheme.titleLarge),
    ),

    sideMenu: Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuLink(icon: Icons.home, label: 'Home', active: true),
          _MenuLink(icon: Icons.analytics, label: 'Analytics'),
          _MenuLink(icon: Icons.people, label: 'Users'),
          Spacer(),
          _MenuLink(icon: Icons.settings, label: 'Settings'),
        ],
      ),
    ),

    // Content (8 Cols)
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Main Content Area', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        ...List.generate(10, (index) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Container(height: 100, alignment: Alignment.center, child: Text('Chart Widget $index')),
        )),
      ],
    ),
  );
}

class _MenuLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _MenuLink({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: active ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: active ? Theme.of(context).colorScheme.primary : Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(
            color: active ? Theme.of(context).colorScheme.primary : Colors.grey[700],
            fontWeight: active ? FontWeight.bold : FontWeight.normal
          )),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Mobile Feed (Sliver Header)',
  type: AppPageView,
)
Widget buildMobileFeed(BuildContext context) {
  final showOverlay = context.knobs.boolean(label: 'Show Grid Overlay', initialValue: true);

  return AppPageView(
    useSlivers: true,
    showGridOverlay: showOverlay,
    
    // Header (Sliver)
    header: SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 160,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Mobile Feed'),
        background: Container(color: Colors.blueGrey),
      ),
    ),

    sideMenu: null,

    // Content (Full Width)
    child: Column(
      children: List.generate(20, (index) => ListTile(
        title: Text('Feed Item #$index'),
        subtitle: const Text('Matches standard mobile behavior'),
        leading: const CircleAvatar(child: Icon(Icons.person)),
      )),
    ),
  );
}
