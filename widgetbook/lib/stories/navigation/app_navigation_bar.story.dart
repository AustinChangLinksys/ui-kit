import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppNavigationBar,
)
Widget buildAppNavigationBar(BuildContext context) {
  // 1. 動態控制項目數量 (測試 2~5 個項目的排列)
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    min: 2,
    max: 5,
    initialValue: 3,
  );

  // 2. 模擬真實擺放位置 (底部)
  return Align(
    alignment: Alignment.bottomCenter,
    child: _InteractiveNavBar(itemCount: itemCount),
  );
}

/// 一個簡單的狀態管理器，讓 NavBar 在 Story 中可以被點擊切換
class _InteractiveNavBar extends StatefulWidget {
  final int itemCount;

  const _InteractiveNavBar({required this.itemCount});

  @override
  State<_InteractiveNavBar> createState() => _InteractiveNavBarState();
}

class _InteractiveNavBarState extends State<_InteractiveNavBar> {
  int _currentIndex = 0;

  // 預定義一組測試資料
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
    // 根據 Knob 截取對應數量的項目
    final items = _allNavItems.take(widget.itemCount).toList();

    // 防呆：如果切換數量導致 index 越界，重置為 0
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
