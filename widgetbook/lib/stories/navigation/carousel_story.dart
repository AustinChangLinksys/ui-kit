import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic Carousel',
  type: AppCarousel,
)
Widget buildBasicCarousel(BuildContext context) {
  final items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppCarousel(
        itemCount: items.length,
        itemHeight: 300,
        itemBuilder: (context, index) {
          return Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    items[index],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  AppText(
                    'Item ${index + 1} of ${items.length}',
                    variant: AppTextVariant.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Auto-Play',
  type: AppCarousel,
)
Widget buildAutoPlayCarousel(BuildContext context) {
  final duration = context.knobs.int.slider(
    label: 'Auto-play duration (seconds)',
    initialValue: 3,
    min: 1,
    max: 10,
  );

  final items = List.generate(5, (i) => 'Item ${i + 1}');

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppCarousel(
        itemCount: items.length,
        itemHeight: 250,
        enableAutoPlay: true,
        autoPlayDuration: Duration(seconds: duration),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: AppText.displaySmall(
                items[index],
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Different Scroll Behaviors',
  type: AppCarousel,
)
Widget buildScrollBehaviorCarousel(BuildContext context) {
  final behavior = context.knobs.object.dropdown(
    label: 'Scroll Behavior',
    options: [
      CarouselScrollBehavior.smooth,
      CarouselScrollBehavior.snap,
      CarouselScrollBehavior.loop,
    ],
  );

  final items = List.generate(5, (i) => 'Item ${i + 1}');

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppCarousel(
        itemCount: items.length,
        itemHeight: 280,
        scrollBehavior: behavior,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade300,
                  Colors.purple.shade300,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.displayMedium(
                    items[index],
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText(
                      'Mode: ${behavior.toString().split('.').last}',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText.labelSmall(
                      'Mode: ${behavior.toString().split('.').last}',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Image Carousel',
  type: AppCarousel,
)
Widget buildImageCarousel(BuildContext context) {
  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppCarousel(
        itemCount: 5,
        itemHeight: 300,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    'Image ${index + 1}',
                    variant: AppTextVariant.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  const AppText(
                    'Swipe or use arrow keys to navigate',
                    variant: AppTextVariant.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
