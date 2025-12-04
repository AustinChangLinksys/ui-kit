import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic Content',
  type: AppBottomSheet,
)
Widget buildBasicBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AppBottomSheet(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.headlineSmall(
                      'Sheet Title',
                    ),
                    const SizedBox(height: 12),
                    const AppText(
                      'This is a basic bottom sheet with simple content.',
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              useSafeArea: true,
            );
          },
          child: const Text('Show Bottom Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Long Content',
  type: AppBottomSheet,
)
Widget buildLongContentBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AppBottomSheet(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.headlineSmall('Options'),
                    const SizedBox(height: 16),
                    ...[
                      'Option 1: First choice',
                      'Option 2: Second choice',
                      'Option 3: Third choice',
                      'Option 4: Fourth choice',
                      'Option 5: Fifth choice',
                    ]
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      return Column(
                        children: [
                          ListTile(
                            title: AppText(label),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          if (index < 4) const Divider(height: 1),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              useSafeArea: true,
            );
          },
          child: const Text('Show Options'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Height',
  type: AppBottomSheet,
)
Widget buildCustomHeightBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final screenHeight = MediaQuery.of(context).size.height;
            showModalBottomSheet(
              context: context,
              builder: (context) => AppBottomSheet(
                maxHeight: screenHeight * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.headlineSmall('Custom Height Sheet'),
                    const SizedBox(height: 16),
                    const AppText('Max height: 60% of screen'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              useSafeArea: true,
            );
          },
          child: const Text('Show Custom Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Non-Dismissible',
  type: AppBottomSheet,
)
Widget buildNonDismissibleBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AppBottomSheet(
                isDismissible: false,
                enableDrag: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.headlineSmall('Confirmation Required'),
                    const SizedBox(height: 16),
                    const AppText(
                      'This sheet cannot be dismissed by tapping outside.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              useSafeArea: true,
            );
          },
          child: const Text('Show Non-Dismissible'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Form',
  type: AppBottomSheet,
)
Widget buildFormBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AppBottomSheet(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.headlineSmall('Add Item'),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter item name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Add Item'),
                      ),
                    ),
                  ],
                ),
              ),
              useSafeArea: true,
            );
          },
          child: const Text('Show Form'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Different Sizes',
  type: AppBottomSheet,
)
Widget buildDifferentSizesBottomSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AppBottomSheet(
                    maxHeight: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.headlineSmall('Short Sheet'),
                        const SizedBox(height: 8),
                        const AppText('Limited height'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                  useSafeArea: true,
                );
              },
              child: const Text('Short Sheet'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AppBottomSheet(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.headlineSmall('Default Sheet'),
                        const SizedBox(height: 8),
                        const AppText('Intrinsic height'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                  useSafeArea: true,
                );
              },
              child: const Text('Default Sheet'),
            ),
          ],
        ),
      ),
    ),
  );
}
