import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_spacing.dart';

/// Icon position relative to the text in button components
enum AppButtonIconPosition {
  /// Icon appears before the text
  leading,
  /// Icon appears after the text
  trailing,
}

/// AppTextButton - A pure text button component that displays clickable text
/// with optional icon support and loading states.
///
/// Follows Constitution 6.1: Uses AppSurface for consistent theme rendering
/// Follows Constitution 6.2: Dumb component with no internal business logic
/// Follows Constitution 3.1: Theme-driven styling via IoC pattern
/// Follows Constitution 3.3: Zero Internal Defaults - all styling from theme
class AppTextButton extends StatelessWidget {
  /// Creates an AppTextButton.
  const AppTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.iconPosition = AppButtonIconPosition.leading,
    this.semanticLabel,
  });

  /// The text to display in the button
  final String text;

  /// Callback for when the button is tapped
  final VoidCallback? onTap;

  /// The size of the button, referencing existing uikit button size enum
  final AppButtonSize size;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Optional icon to display alongside the text
  final IconData? icon;

  /// Position of the icon relative to the text
  final AppButtonIconPosition iconPosition;

  /// Semantic label for accessibility
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designTheme = theme.extension<AppDesignTheme>();

    // Constitution 3.3: Zero Internal Defaults - get all styling from theme
    if (designTheme == null) {
      throw FlutterError(
        'AppTextButton requires AppDesignTheme to be provided in the widget tree. '
        'Ensure AppDesignSystem is initialized in MaterialApp.builder.',
      );
    }

    final textButtonStyle = designTheme.textButtonStyle;
    final isEnabled = onTap != null && !isLoading;

    // Get size-specific dimensions
    final buttonHeight = _getButtonHeight(size, designTheme);
    final padding = _getPadding(size, designTheme);

    return Semantics(
      label: semanticLabel ?? text,
      button: true,
      enabled: isEnabled,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: AppSurface(
          // Constitution 6.1: Use AppSurface for consistent theme rendering
          style: _getSurfaceStyle(textButtonStyle, isEnabled),
          height: buttonHeight,
          child: Padding(
            padding: padding,
            child: _buildContent(context, designTheme, textButtonStyle),
          ),
        ),
      ),
    );
  }

  /// Gets the surface style based on button state
  SurfaceStyle _getSurfaceStyle(TextButtonStyle style, bool isEnabled) {
    if (!isEnabled) {
      return style.disabledStyle;
    }
    return style.enabledStyle;
  }

  /// Builds the button content (text with optional icon and loading state)
  Widget _buildContent(
    BuildContext context,
    AppDesignTheme designTheme,
    TextButtonStyle style,
  ) {
    if (isLoading) {
      return _buildLoadingContent(designTheme);
    }

    if (icon != null) {
      return _buildTextWithIcon(context, designTheme, style);
    }

    return _buildText(context, designTheme, style);
  }

  /// Builds loading state content
  Widget _buildLoadingContent(AppDesignTheme designTheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: _getIconSize(size, designTheme),
          height: _getIconSize(size, designTheme),
          child: const AppLoader(
            // Use theme's loader configuration for consistent styling
            variant: LoaderVariant.circular,
          ),
        ),
        AppGap.sm(),
        _buildText(null, designTheme, designTheme.textButtonStyle),
      ],
    );
  }

  /// Builds text with icon
  Widget _buildTextWithIcon(
    BuildContext context,
    AppDesignTheme designTheme,
    TextButtonStyle style,
  ) {
    final iconWidget = Icon(
      icon!,
      size: _getIconSize(size, designTheme),
      color: _getContentColor(style, onTap != null && !isLoading),
    );

    final textWidget = _buildText(context, designTheme, style);

    if (iconPosition == AppButtonIconPosition.leading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          AppGap.sm(),
          textWidget,
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textWidget,
          AppGap.sm(),
          iconWidget,
        ],
      );
    }
  }

  /// Builds the text widget
  Widget _buildText(
    BuildContext? context,
    AppDesignTheme designTheme,
    TextButtonStyle style,
  ) {
    return Text(
      text,
      style: _getTextStyle(size, designTheme, style).copyWith(
        color: _getContentColor(style, onTap != null && !isLoading),
      ),
    );
  }

  /// Gets the text style based on button size
  TextStyle _getTextStyle(
    AppButtonSize size,
    AppDesignTheme designTheme,
    TextButtonStyle style,
  ) {
    switch (size) {
      case AppButtonSize.small:
        return style.smallTextStyle;
      case AppButtonSize.medium:
        return style.mediumTextStyle;
      case AppButtonSize.large:
        return style.largeTextStyle;
    }
  }

  /// Gets the content color based on button state
  Color _getContentColor(TextButtonStyle style, bool isEnabled) {
    return isEnabled ? style.enabledContentColor : style.disabledContentColor;
  }

  /// Gets button height based on size and theme configuration
  double _getButtonHeight(AppButtonSize size, AppDesignTheme designTheme) {
    switch (size) {
      case AppButtonSize.small:
        return designTheme.buttonHeight * 0.8;
      case AppButtonSize.medium:
        return designTheme.buttonHeight;
      case AppButtonSize.large:
        return designTheme.buttonHeight * 1.2;
    }
  }

  /// Gets padding based on button size
  EdgeInsets _getPadding(AppButtonSize size, AppDesignTheme designTheme) {
    const baseSpacing = AppSpacing.md;
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: baseSpacing * 0.75,
          vertical: baseSpacing * 0.5,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: baseSpacing,
          vertical: baseSpacing * 0.75,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: baseSpacing * 1.25,
          vertical: baseSpacing,
        );
    }
  }

  /// Gets icon size based on button size
  double _getIconSize(AppButtonSize size, AppDesignTheme designTheme) {
    switch (size) {
      case AppButtonSize.small:
        return 16.0;
      case AppButtonSize.medium:
        return 20.0;
      case AppButtonSize.large:
        return 24.0;
    }
  }
}