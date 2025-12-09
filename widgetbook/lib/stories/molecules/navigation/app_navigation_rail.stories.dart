import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Rail (Desktop Layout)',
  type: AppNavigationRail,
)
Widget buildNavigationRail(BuildContext context) {
  return _InteractiveRailWrapper();
}

class _InteractiveRailWrapper extends StatefulWidget {
  @override
  State<_InteractiveRailWrapper> createState() => _InteractiveRailWrapperState();
}

class _InteractiveRailWrapperState extends State<_InteractiveRailWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNavigationRail(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            // ✨ Selected item (index 0): Shows Tonal pill indicator
            AppNavigationItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            // Unselected items: Reduced opacity text/icons
            AppNavigationItem(icon: Icon(Icons.analytics), label: 'Analytics'),
            AppNavigationItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 16,
              child: const Text('A', style: TextStyle(color: Colors.white)),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ),

        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Selected: $_currentIndex',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '✨ Selected item uses Tonal surface\nwith 8px rounded corners\n(consistent with bottom nav)',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}