import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Default AppBar',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarDefault(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Dashboard',
  );
  final centerTitle = context.knobs.boolean(
    label: 'Center Title',
    initialValue: true,
  );
  final showActions = context.knobs.boolean(
    label: 'Show Actions',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppUnifiedBar(
      title: title,
      centerTitle: centerTitle,
      actions: showActions
          ? [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ]
          : null,
    ),
    body: const Center(
      child: Text('Page Content'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Leading',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarWithLeading(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Settings',
  );
  final autoImplyLeading = context.knobs.boolean(
    label: 'Auto Imply Leading',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppUnifiedBar(
      title: title,
      automaticallyImplyLeading: autoImplyLeading,
      leading: autoImplyLeading
          ? null
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
    ),
    body: const Center(
      child: Text('Page Content'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Bottom (TabBar)',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarWithBottom(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Products',
  );

  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppUnifiedBar(
        title: title,
        bottom: const TabBar(
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Archived'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Center(child: Text('All Products')),
          Center(child: Text('Active Products')),
          Center(child: Text('Archived Products')),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Title Widget',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarCustomTitle(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Profile',
      titleWidget: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            child: Icon(Icons.person, size: 20),
          ),
          SizedBox(width: 8),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ],
    ),
    body: const Center(
      child: Text('Profile Content'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Left Aligned Title',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarLeftAligned(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'My Documents',
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Drawer opened'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
        AppPopupMenu<String>(
          items: const [
            AppPopupMenuItem(value: 'sort_name', label: 'Sort by Name', icon: Icons.sort_by_alpha),
            AppPopupMenuItem(value: 'sort_date', label: 'Sort by Date', icon: Icons.calendar_today),
            AppPopupMenuItem(value: 'sort_size', label: 'Sort by Size', icon: Icons.data_usage),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected: $value'), duration: const Duration(seconds: 1)),
            );
          },
        ),
      ],
    ),
    body: const Center(
      child: Text('Documents List'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Drawer Menu',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarWithDrawer(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Inbox',
      centerTitle: false,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Inbox'),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Sent'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.drafts),
            title: const Text('Drafts'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
    body: const Center(
      child: Text('Email List'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Search Field',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarWithSearch(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Search',
      centerTitle: false,
      titleWidget: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {},
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {},
        ),
      ],
    ),
    body: const Center(
      child: Text('Search Results'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Action Badges',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarWithBadges(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Notifications',
      centerTitle: true,
      actions: [
        // Notification with badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Cart with badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '12',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {},
        ),
      ],
    ),
    body: const Center(
      child: Text('Content'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Detailed Page (Back + Actions)',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarDetailPage(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Product Details',
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Back pressed'), duration: Duration(seconds: 1)),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        ),
        AppPopupMenu<String>(
          items: const [
            AppPopupMenuItem(value: 'report', label: 'Report', icon: Icons.flag),
            AppPopupMenuItem(value: 'block', label: 'Block Seller', icon: Icons.block),
          ],
          onSelected: (value) {},
        ),
      ],
    ),
    body: const Center(
      child: Text('Product Info'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Transparent / Overlay Style',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarTransparent(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppUnifiedBar(
      title: 'Photo Gallery',
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {},
        ),
      ],
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 120),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multiple Action Groups',
  type: AppUnifiedBar,
)
Widget buildAppUnifiedBarMultipleActions(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Text Editor',
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      actions: [
        // Undo/Redo group
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: () {},
          tooltip: 'Undo',
        ),
        IconButton(
          icon: const Icon(Icons.redo),
          onPressed: () {},
          tooltip: 'Redo',
        ),
        // Divider
        Container(
          height: 24,
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          color: Theme.of(context).dividerColor,
        ),
        // Format group
        IconButton(
          icon: const Icon(Icons.format_bold),
          onPressed: () {},
          tooltip: 'Bold',
        ),
        IconButton(
          icon: const Icon(Icons.format_italic),
          onPressed: () {},
          tooltip: 'Italic',
        ),
        // Divider
        Container(
          height: 24,
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          color: Theme.of(context).dividerColor,
        ),
        // More options
        AppPopupMenu<String>(
          items: const [
            AppPopupMenuItem(value: 'save', label: 'Save', icon: Icons.save),
            AppPopupMenuItem(value: 'export', label: 'Export', icon: Icons.download),
            AppPopupMenuItem(value: 'print', label: 'Print', icon: Icons.print),
          ],
          onSelected: (value) {},
        ),
      ],
    ),
    body: const Center(
      child: Text('Editor Content'),
    ),
  );
}
