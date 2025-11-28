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
        const AppSkeleton.text(width: 150), // 短標題
        const AppSkeleton.text(width: double.infinity), // 長文
        const AppSkeleton.text(width: 200), // 中長文
        const SizedBox(height: 32),

        Text('Shape Skeletons', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Avatar
            AppSkeleton.circular(size: 64),
            // Icon Button
            AppSkeleton.circular(size: 48),
            // Chip / Tag
            AppSkeleton(width: 80, height: 32, shape: StadiumBorder()),
            // Square Thumbnail
            AppSkeleton(
                width: 80,
                height: 80,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
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
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSkeleton(
                  width: 80,
                  height: 80,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton.text(width: 120, fontSize: 16),
                    SizedBox(height: 8),
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
  return const Center(
    child: AppDialog(
      // 模擬標題
      title: AppSkeleton.text(width: 120, fontSize: 20),

      // 模擬內容區域
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeleton.text(width: double.infinity),
          AppSkeleton.text(width: double.infinity),
          AppSkeleton.text(width: 200),
          SizedBox(height: 16),
          // 模擬一個輸入框或區塊
          AppSkeleton(width: double.infinity, height: 48),
        ],
      ),

      // 模擬按鈕區域
      actions: [
        AppSkeleton(width: 80, height: 36, shape: StadiumBorder()),
        SizedBox(width: 8),
        AppSkeleton(width: 80, height: 36, shape: StadiumBorder()),
      ],
    ),
  );
}
