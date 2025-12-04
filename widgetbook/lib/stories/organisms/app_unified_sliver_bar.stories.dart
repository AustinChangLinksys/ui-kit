import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Expanded with Image',
  type: AppUnifiedSliverBar,
)
Widget buildAppUnifiedSliverBarExpanded(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Profile',
  );
  final expandedHeight = context.knobs.double.slider(
    label: 'Expanded Height',
    initialValue: 200,
    min: 150,
    max: 300,
  );
  final pinned = context.knobs.boolean(
    label: 'Pinned',
    initialValue: true,
  );

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppUnifiedSliverBar(
          title: title,
          expandedHeight: expandedHeight,
          pinned: pinned,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 64, color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: const Text('Subtitle text'),
            ),
            childCount: 20,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Collapsed (No Flexible Space)',
  type: AppUnifiedSliverBar,
)
Widget buildAppUnifiedSliverBarCollapsed(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Dashboard',
  );
  final pinned = context.knobs.boolean(
    label: 'Pinned',
    initialValue: true,
  );
  final floating = context.knobs.boolean(
    label: 'Floating',
    initialValue: false,
  );

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppUnifiedSliverBar(
          title: title,
          pinned: pinned,
          floating: floating,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Item ${index + 1}'),
              subtitle: const Text('Description'),
            ),
            childCount: 30,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Floating with Snap',
  type: AppUnifiedSliverBar,
)
Widget buildAppUnifiedSliverBarFloating(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Feed',
  );

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppUnifiedSliverBar(
          title: title,
          pinned: false,
          floating: true,
          snap: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Post ${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    ),
                  ],
                ),
              ),
            ),
            childCount: 20,
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Custom Title Widget',
  type: AppUnifiedSliverBar,
)
Widget buildAppUnifiedSliverBarCustomTitle(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        const AppUnifiedSliverBar(
          title: 'Messages',
          titleWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chat_bubble_outline),
              SizedBox(width: 8),
              Text(
                'Messages',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  '5',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text('Contact ${index + 1}'),
              subtitle: const Text('Last message...'),
              trailing: const Text('12:30'),
            ),
            childCount: 15,
          ),
        ),
      ],
    ),
  );
}
