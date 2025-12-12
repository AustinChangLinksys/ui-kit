import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A bottom action bar component for page layouts
///
/// This component provides a standardized bottom bar for pages with
/// primary and secondary action buttons. It follows Material Design
/// guidelines and integrates with the UI Kit theme system.
///
/// Features:
/// - Primary and secondary action buttons
/// - Destructive action styling
/// - Safe area handling
/// - Responsive layout
/// - Theme-aware styling
///
/// Example usage:
/// ```dart
/// PageBottomBar(
///   config: PageBottomBarConfig(
///     positiveLabel: 'Save Changes',
///     negativeLabel: 'Cancel',
///     onPositiveTap: () => _saveChanges(),
///     onNegativeTap: () => _cancel(),
///   ),
/// )
/// ```
class PageBottomBar extends StatelessWidget {
  /// Creates a page bottom bar with the specified configuration
  const PageBottomBar({
    super.key,
    required this.config,
    this.safeArea = true,
  });

  /// Configuration for the bottom bar appearance and behavior
  final PageBottomBarConfig config;

  /// Whether to apply safe area padding
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designTheme = theme.extension<AppDesignTheme>();
    final bottomBarStyle = designTheme?.bottomBarStyle;

    if (bottomBarStyle == null) {
      // Fallback to basic styling if theme is not available
      return _buildFallbackBottomBar(context);
    }

    final widget = Container(
      height: bottomBarStyle.height,
      decoration: BoxDecoration(
        color: bottomBarStyle.backgroundColor,
        borderRadius: bottomBarStyle.borderRadius,
        border: bottomBarStyle.border,
        boxShadow: bottomBarStyle.elevation > 0
            ? [
                BoxShadow(
                  color: bottomBarStyle.shadowColor,
                  blurRadius: bottomBarStyle.elevation * 2,
                  offset: Offset(0, -bottomBarStyle.elevation),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: bottomBarStyle.padding,
        child: _buildButtonRow(context, bottomBarStyle),
      ),
    );

    return safeArea
        ? SafeArea(
            child: widget,
          )
        : widget;
  }

  Widget _buildButtonRow(BuildContext context, dynamic bottomBarStyle) {
    final buttons = <Widget>[];

    // Add negative (secondary) button if present
    if (config.negativeLabel != null || config.onNegativeTap != null) {
      buttons.add(
        Expanded(
          child: SizedBox(
            height: bottomBarStyle.buttonHeight,
            child: AppButton.text(
              label: config.negativeLabel ?? 'Cancel',
              onTap: (config.isNegativeEnabled ?? true) ? config.onNegativeTap ?? () {} : null,
            ),
          ),
        ),
      );
    }

    // Add spacing between buttons if both are present
    if (buttons.isNotEmpty &&
        (config.positiveLabel != null || config.onPositiveTap != null)) {
      buttons.add(AppGap.md());
    }

    // Add positive (primary) button if present
    if (config.positiveLabel != null || config.onPositiveTap != null) {
      buttons.add(
        Expanded(
          child: SizedBox(
            height: bottomBarStyle.buttonHeight,
            child: AppButton.primary(
              label: config.positiveLabel ?? 'OK',
              onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Widget _buildFallbackBottomBar(BuildContext context) {
    final theme = Theme.of(context);

    final widget = Container(
      height: 72.0,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildFallbackButtonRow(context),
      ),
    );

    return safeArea
        ? SafeArea(
            child: widget,
          )
        : widget;
  }

  Widget _buildFallbackButtonRow(BuildContext context) {
    final buttons = <Widget>[];

    // Add negative (secondary) button if present
    if (config.negativeLabel != null || config.onNegativeTap != null) {
      buttons.add(
        Expanded(
          child: SizedBox(
            height: 40.0,
            child: AppButton.text(
              label: config.negativeLabel ?? 'Cancel',
              onTap: (config.isNegativeEnabled ?? true) ? config.onNegativeTap ?? () {} : null,
            ),
          ),
        ),
      );
    }

    // Add spacing between buttons if both are present
    if (buttons.isNotEmpty &&
        (config.positiveLabel != null || config.onPositiveTap != null)) {
      buttons.add(AppGap.sm());
    }

    // Add positive (primary) button if present
    if (config.positiveLabel != null || config.onPositiveTap != null) {
      buttons.add(
        Expanded(
          child: SizedBox(
            height: 40.0,
            child: config.isDestructive
                ? AppButton.danger(
                    label: config.positiveLabel ?? 'Delete',
                    onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
                  )
                : AppButton.primary(
                    label: config.positiveLabel ?? 'OK',
                    onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
                  ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}

/// Extension methods for common PageBottomBar configurations
extension PageBottomBarExtensions on PageBottomBar {
  /// Creates a save/cancel bottom bar
  static PageBottomBar saveCancel({
    required VoidCallback onSave,
    required VoidCallback onCancel,
    bool canSave = true,
    bool safeArea = true,
  }) {
    return PageBottomBar(
      config: PageBottomBarConfig(
        positiveLabel: 'Save',
        negativeLabel: 'Cancel',
        onPositiveTap: onSave,
        onNegativeTap: onCancel,
        isPositiveEnabled: canSave,
        isNegativeEnabled: true,
        isDestructive: false,
      ),
      safeArea: safeArea,
    );
  }

  /// Creates a delete/keep bottom bar
  static PageBottomBar deleteKeep({
    required VoidCallback onDelete,
    required VoidCallback onKeep,
    bool canDelete = true,
    bool safeArea = true,
  }) {
    return PageBottomBar(
      config: PageBottomBarConfig(
        positiveLabel: 'Delete',
        negativeLabel: 'Keep',
        onPositiveTap: onDelete,
        onNegativeTap: onKeep,
        isPositiveEnabled: canDelete,
        isNegativeEnabled: true,
        isDestructive: true,
      ),
      safeArea: safeArea,
    );
  }

  /// Creates a continue/back bottom bar
  static PageBottomBar continueBack({
    required VoidCallback onContinue,
    required VoidCallback onBack,
    bool canContinue = true,
    bool safeArea = true,
  }) {
    return PageBottomBar(
      config: PageBottomBarConfig(
        positiveLabel: 'Continue',
        negativeLabel: 'Back',
        onPositiveTap: onContinue,
        onNegativeTap: onBack,
        isPositiveEnabled: canContinue,
        isNegativeEnabled: true,
        isDestructive: false,
      ),
      safeArea: safeArea,
    );
  }

  /// Creates a single action bottom bar
  static PageBottomBar singleAction({
    required String label,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isDestructive = false,
    bool safeArea = true,
  }) {
    return PageBottomBar(
      config: PageBottomBarConfig(
        positiveLabel: label,
        onPositiveTap: onPressed,
        isPositiveEnabled: enabled,
        isDestructive: isDestructive,
      ),
      safeArea: safeArea,
    );
  }
}