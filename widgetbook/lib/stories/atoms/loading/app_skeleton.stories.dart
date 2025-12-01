import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Standard Playground',
  type: AppSkeleton,
)
Widget buildAppSkeletonPlayground(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text Skeletons', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        AppSkeleton.text(width: 150), // Short title
        AppSkeleton.text(width: double.infinity), // Long text
        AppSkeleton.text(width: 200), // Medium length text
        const SizedBox(height: 32),

        Text('Shape Skeletons', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Avatar
            AppSkeleton.circular(size: 64),
            // Icon Button
            AppSkeleton.circular(size: 48),
            // Chip / Tag
            AppSkeleton.capsule(width: 80, height: 32),
            // Square Thumbnail
            AppSkeleton(
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        const SizedBox(height: 32),

        Text('Composite Example (Card)',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeleton(
                width: 80,
                height: 80,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton.text(width: 120, height: 16),
                    const SizedBox(height: 8),
                    AppSkeleton.text(width: double.infinity),
                    AppSkeleton.text(width: 180),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dialog Skeleton',
  type: AppSkeleton,
)
Widget buildDialogSkeleton(BuildContext context) {
  return Center(
    child: AppDialog(
      // Simulate title
      title: AppSkeleton.text(width: 120),

      // Simulate content area
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeleton.text(width: double.infinity),
          AppSkeleton.text(width: double.infinity),
          AppSkeleton.text(width: 200),
          const SizedBox(height: 16),
          // Simulate an input box or block
          const AppSkeleton(width: double.infinity, height: 48),
        ],
      ),

      // Simulate button area
      actions: [
        AppSkeleton.capsule(width: 80, height: 36),
        const SizedBox(width: 8),
        AppSkeleton.capsule(width: 80, height: 36),
      ],
    ),
  );
}
