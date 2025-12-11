import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Stateful widget to demonstrate overlay functionality
class _FullScreenLoaderStory extends StatefulWidget {
  const _FullScreenLoaderStory();

  @override
  _FullScreenLoaderStoryState createState() => _FullScreenLoaderStoryState();
}

class _FullScreenLoaderStoryState extends State<_FullScreenLoaderStory> {
  bool _isLoading = false;

  void _showLoader(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    // Get configuration from knobs
    final title =
        context.knobs.string(label: 'Title', initialValue: 'Loading...');
    final description = context.knobs.string(
        label: 'Description',
        initialValue: 'Please wait while we process your request.');
    final dismissible =
        context.knobs.boolean(label: 'Dismissible', initialValue: false);
    final duration = context.knobs.int.slider(
        label: 'Auto-dismiss Duration (seconds)',
        initialValue: 3,
        min: 1,
        max: 10);

    try {
      await showFullScreenLoader<void>(
        context: context,
        title: title.isEmpty ? null : title,
        description: description.isEmpty ? null : description,
        dismissible: dismissible,
        future: Future.delayed(Duration(seconds: duration)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.headlineSmall('AppFullScreenLoader Demo'),
            AppGap.lg(),
            AppText.bodyMedium(
                'Configure the loader properties below and tap "Show Loader"'),
            AppGap.lg(),

            // Configuration info
            AppSurface(
              variant: SurfaceVariant.elevated,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodySmall('Configuration:'),
                  AppGap.xs(),
                  AppText.bodySmall('• Use knobs in the sidebar to customize'),
                  AppText.bodySmall('• Title: Optional loader title text'),
                  AppText.bodySmall('• Description: Optional description text'),
                  AppText.bodySmall(
                      '• Dismissible: Allow back button to dismiss'),
                  AppText.bodySmall('• Duration: Auto-dismiss after N seconds'),
                ],
              ),
            ),

            AppGap.lg(),

            AppButton(
              label: _isLoading ? 'Loading...' : 'Show Loader',
              onTap: _isLoading ? null : () => _showLoader(context),
              variant: SurfaceVariant.highlight,
              styleVariant: ButtonStyleVariant.filled,
            ),

            AppGap.md(),

            if (_isLoading)
              Text('Loader is currently active',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  )),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Interactive Demo',
  type: AppFullScreenLoader,
)
Widget buildFullScreenLoaderDemo(BuildContext context) {
  return const _FullScreenLoaderStory();
}

@widgetbook.UseCase(
  name: 'Static Preview',
  type: AppFullScreenLoader,
)
Widget buildFullScreenLoaderPreview(BuildContext context) {
  final title =
      context.knobs.string(label: 'Title', initialValue: 'Processing...');
  final description = context.knobs.string(
      label: 'Description', initialValue: 'This may take a few moments.');
  final dismissible =
      context.knobs.boolean(label: 'Dismissible', initialValue: false);
  final useCustomLoader =
      context.knobs.boolean(label: 'Use Custom Loader', initialValue: false);

  Widget? customLoader;
  if (useCustomLoader) {
    customLoader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        AppGap.md(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon.font(Icons.cloud_upload, size: 20),
            AppGap.xs(),
            AppText.bodyMedium('Uploading files...'),
          ],
        ),
      ],
    );
  }

  return AppFullScreenLoader(
    title: title.isEmpty ? null : title,
    description: description.isEmpty ? null : description,
    dismissible: dismissible,
    customLoader: customLoader,
    onDismiss: () {
      // Show feedback when dismissed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loader was dismissed')),
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Different Configurations',
  type: AppFullScreenLoader,
)
Widget buildFullScreenLoaderVariations(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.headlineSmall('AppFullScreenLoader Variations'),
        AppGap.lg(),

        // Minimal loader
        _buildVariationCard(
          context,
          'Minimal Loader',
          'Just the loading indicator, no text',
          AppFullScreenLoader(
            backgroundColor:
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
          ),
        ),

        AppGap.lg(),

        // With title only
        _buildVariationCard(
          context,
          'With Title Only',
          'Loading indicator with title text',
          AppFullScreenLoader(
            title: 'Loading...',
            backgroundColor:
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
          ),
        ),

        AppGap.lg(),

        // With title and description
        _buildVariationCard(
          context,
          'Complete Information',
          'Title, description, and loading indicator',
          AppFullScreenLoader(
            title: 'Syncing Data',
            description:
                'Downloading the latest updates from the server. This may take a moment.',
            backgroundColor:
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          ),
        ),

        AppGap.lg(),

        // Custom loader
        _buildVariationCard(
          context,
          'Custom Loader Widget',
          'Using a custom loading animation',
          AppFullScreenLoader(
            title: 'Processing',
            description: 'Custom animation example',
            backgroundColor:
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
            customLoader: AppSurface(
              variant: SurfaceVariant.elevated,
              style: (AppDesignTheme.of(context).surfaceElevated).copyWith(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                borderRadius: 40.0,
              ),
              width: 80,
              height: 80,
              child: Center(
                child: AppIcon.font(
                  Icons.refresh,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVariationCard(
    BuildContext context, String title, String description, Widget preview) {
  return AppSurface(
    variant: SurfaceVariant.base,
    style: AppDesignTheme.of(context).surfaceBase.copyWith(
          borderColor:
              Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 8.0,
        ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
        AppGap.xs(),
        Text(description,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            )),
        AppGap.md(),

        // Preview container
        AppSurface(
          variant: SurfaceVariant.base,
          style: AppDesignTheme.of(context).surfaceBase.copyWith(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius: 4.0,
              ),
          width: double.infinity,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                // Background pattern to show transparency
                AppSurface(
                  variant: SurfaceVariant.base,
                  style: AppDesignTheme.of(context).surfaceBase.copyWith(
                        texture: NetworkImage(
                            'data:image/svg+xml,${Uri.encodeComponent('<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg"><rect width="10" height="10" fill="%23f0f0f0"/><rect x="10" y="10" width="10" height="10" fill="%23f0f0f0"/></svg>')}'),
                        textureOpacity: 1.0,
                      ),
                  width: double.infinity,
                  height: double.infinity,
                  child: const SizedBox.shrink(),
                ),
                // The actual loader preview
                preview,
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
