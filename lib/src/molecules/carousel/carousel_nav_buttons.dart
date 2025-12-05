import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Navigation buttons for carousel component
///
/// Provides previous/next buttons with disabled state at boundaries.
/// Uses AppSurface with interactive styling for consistent theme support.
class CarouselNavButtons extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool canGoPrevious;
  final bool canGoNext;
  final double buttonSize;
  final MainAxisAlignment alignment;

  const CarouselNavButtons({
    super.key,
    this.onPrevious,
    this.onNext,
    required this.canGoPrevious,
    required this.canGoNext,
    this.buttonSize = 48.0,
    this.alignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();

    return Row(
      mainAxisAlignment: alignment,
      children: [
        // Previous button
        Semantics(
          enabled: canGoPrevious,
          label: 'Previous item',
          button: true,
          child: _NavButton(
            icon: theme?.carouselStyle.previousIcon ?? Icons.arrow_back,
            onPressed: canGoPrevious ? onPrevious : null,
            size: buttonSize,
          ),
        ),
        // Next button
        Semantics(
          enabled: canGoNext,
          label: 'Next item',
          button: true,
          child: _NavButton(
            icon: theme?.carouselStyle.nextIcon ?? Icons.arrow_forward,
            onPressed: canGoNext ? onNext : null,
            size: buttonSize,
          ),
        ),
      ],
    );
  }
}

/// Single navigation button with theme-aware styling
class _NavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;

  const _NavButton({
    required this.icon,
    required this.onPressed,
    required this.size,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final isEnabled = widget.onPressed != null;

    return AppSurface(
      interactive: isEnabled,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: isEnabled
                  ? (_isHovered
                      ? theme?.carouselStyle.navButtonHoverColor ??
                          Colors.grey[400]
                      : theme?.carouselStyle.navButtonColor ?? Colors.grey)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              color: isEnabled ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
