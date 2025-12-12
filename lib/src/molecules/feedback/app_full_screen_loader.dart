import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppFullScreenLoader extends StatelessWidget {
  /// Creates a full-screen loader overlay that covers the entire screen
  const AppFullScreenLoader({
    super.key,
    this.title,
    this.description,
    this.backgroundColor,
    this.customLoader,
    this.dismissible = false,
    this.onDismiss,
  });

  /// Title text displayed above the loader
  final String? title;

  /// Description text displayed below the title
  final String? description;

  /// Background color of the full-screen overlay
  /// If null, uses theme's surface background color
  final Color? backgroundColor;

  /// Custom loader widget to display instead of default AppLoader
  final Widget? customLoader;

  /// Whether the loader can be dismissed by pressing back button
  final bool dismissible;

  /// Callback when the loader is dismissed (only if dismissible is true)
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);

    return PopScope(
      canPop: dismissible,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && onDismiss != null) {
          onDismiss!();
        }
      },
      child: AppSurface(
        variant: SurfaceVariant.base,
        style: theme.surfaceBase.copyWith(
          backgroundColor: backgroundColor ??
              theme.surfaceBase.backgroundColor.withValues(alpha: 0.9),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Loader
              customLoader ??
                  const AppLoader(
                    variant: LoaderVariant.circular,
                  ),

              // Spacing
              if (title != null || description != null) AppGap.lg(),

              // Title
              if (title != null) ...[
                AppText.headlineSmall(title!),
                if (description != null) AppGap.sm(),
              ],

              // Description
              if (description != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: AppText.bodyMedium(
                    description!,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Utility function to show AppFullScreenLoader as an overlay
Future<T?> showFullScreenLoader<T>({
  required BuildContext context,
  String? title,
  String? description,
  Color? backgroundColor,
  Widget? customLoader,
  bool dismissible = false,
  Future<T>? future,
}) async {
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => AppFullScreenLoader(
      title: title,
      description: description,
      backgroundColor: backgroundColor,
      customLoader: customLoader,
      dismissible: dismissible,
      onDismiss: () => overlayEntry.remove(),
    ),
  );

  // Show the overlay
  Overlay.of(context).insert(overlayEntry);

  try {
    // If future is provided, wait for it to complete
    if (future != null) {
      final result = await future;
      overlayEntry.remove();
      return result;
    }

    return null;
  } catch (error) {
    overlayEntry.remove();
    rethrow;
  }
}

/// Utility function to dismiss the full-screen loader overlay
void hideFullScreenLoader(OverlayEntry overlayEntry) {
  overlayEntry.remove();
}
