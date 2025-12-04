import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Styles',
  type: AppIcon,
)
Widget buildAppIconUseCase(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Icon Style Demo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using built-in assets from Assets class if available, or mock
              // Assuming Assets.icons.search exists based on file structure
              AppIcon(
                Assets.icons.search,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 32),
              AppIcon.font(
                Icons.home_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Switch themes to see adaptive styling:\n' 
            '• Flat: Standard Vector\n' 
            '• Glass: Glow Effect (Simulated Stroke)\n' 
            '• Pixel: Standard (Future: Aliased)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}