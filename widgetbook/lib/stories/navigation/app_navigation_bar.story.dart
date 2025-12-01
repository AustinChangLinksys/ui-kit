import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppNavigationBar,
)
Widget buildAppNavigationBar(BuildContext context) {
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    min: 2,
    max: 5,
    initialValue: 3,
  );

  return Align(
    alignment: Alignment.bottomCenter,
    child: _InteractiveNavBar(itemCount: itemCount),
  );
}

class _InteractiveNavBar extends StatefulWidget {
  final int itemCount;

  const _InteractiveNavBar({required this.itemCount});

  @override
  State<_InteractiveNavBar> createState() => _InteractiveNavBarState();
}

class _InteractiveNavBarState extends State<_InteractiveNavBar> {
  int _currentIndex = 0;

  static const _allNavItems = [
    AppNavigationItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    AppNavigationItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    AppNavigationItem(
      icon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: 'Create',
    ),
    AppNavigationItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Activity',
    ),
    AppNavigationItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _allNavItems.take(widget.itemCount).toList();

    if (_currentIndex >= items.length) {
      _currentIndex = 0;
    }

    return AppNavigationBar(
      items: items,
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
    );
  }
}
