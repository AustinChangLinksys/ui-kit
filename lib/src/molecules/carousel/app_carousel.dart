import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Carousel component for displaying sequential items with navigation
///
/// Supports automatic playback, theme-aware animations (smooth for Glass/Brutal,
/// snap for Pixel), and comprehensive keyboard/accessibility support.
///
/// Usage:
/// ```dart
/// AppCarousel(
///   itemCount: 5,
///   itemHeight: 300,
///   itemBuilder: (context, index) => Image.asset('image_$index.jpg'),
///   onIndexChanged: (index) => print('Current: $index'),
/// )
/// ```
class AppCarousel extends StatefulWidget {
  // Content
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  // Sizing
  final double itemHeight;
  final double? itemWidth;
  final EdgeInsets padding;

  // Behavior
  final CarouselScrollBehavior scrollBehavior;
  final ValueChanged<int>? onIndexChanged;
  final bool enableAutoPlay;
  final Duration autoPlayDuration;

  // Navigation
  final bool showNavigationButtons;
  final CarouselStyle? style;

  const AppCarousel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemHeight,
    this.itemWidth,
    this.padding = const EdgeInsets.all(0),
    this.scrollBehavior = CarouselScrollBehavior.smooth,
    this.onIndexChanged,
    this.enableAutoPlay = false,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.showNavigationButtons = true,
    this.style,
  });

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel>
    with TickerProviderStateMixin {
  late ValueNotifier<int> _currentIndex;
  late PageController _pageController;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = ValueNotifier<int>(0);
    _pageController = PageController();

    if (widget.enableAutoPlay) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoPlayDuration, (_) {
      if (_currentIndex.value < widget.itemCount - 1) {
        _pageController.nextPage(
          duration: _getAnimationDuration(),
          curve: _getAnimationCurve(),
        );
      } else if (widget.scrollBehavior == CarouselScrollBehavior.loop) {
        _pageController.jumpToPage(0);
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  @override
  void didUpdateWidget(AppCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.enableAutoPlay != widget.enableAutoPlay) {
      if (widget.enableAutoPlay) {
        _startAutoPlay();
      } else {
        _stopAutoPlay();
      }
    }
  }

  Duration _getAnimationDuration() {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    return theme?.carouselStyle.animationDuration ??
        const Duration(milliseconds: 300);
  }

  Curve _getAnimationCurve() {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    return theme?.carouselStyle.animationCurve ?? Curves.easeInOut;
  }

  bool _useSnapScroll() {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    return theme?.carouselStyle.useSnapScroll ?? false;
  }

  void _goToPage(int index) {
    if (index >= 0 && index < widget.itemCount) {
      if (_useSnapScroll()) {
        _pageController.jumpToPage(index);
      } else {
        _pageController.animateToPage(
          index,
          duration: _getAnimationDuration(),
          curve: _getAnimationCurve(),
        );
      }
      _currentIndex.value = index;
      widget.onIndexChanged?.call(index);
    }
  }

  void _goNext() {
    if (_currentIndex.value < widget.itemCount - 1) {
      _goToPage(_currentIndex.value + 1);
    } else if (widget.scrollBehavior == CarouselScrollBehavior.loop) {
      _goToPage(0);
    }
  }

  void _goPrevious() {
    if (_currentIndex.value > 0) {
      _goToPage(_currentIndex.value - 1);
    } else if (widget.scrollBehavior == CarouselScrollBehavior.loop) {
      _goToPage(widget.itemCount - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final navButtonSize = theme?.carouselStyle.navButtonSize ?? 48.0;

    return Semantics(
      label: 'Carousel',
      child: Padding(
        padding: widget.padding,
        child: Column(
          children: [
            // Carousel content
            Expanded(
              child: Focus(
                onKeyEvent: (node, event) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                    _goNext();
                    return KeyEventResult.handled;
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    _goPrevious();
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _currentIndex.value = index;
                    widget.onIndexChanged?.call(index);
                  },
                  itemCount: widget.itemCount,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: widget.itemHeight,
                      width: widget.itemWidth,
                      child: widget.itemBuilder(context, index),
                    );
                  },
                ),
              ),
            ),
            // Navigation buttons
            if (widget.showNavigationButtons)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, currentIndex, _) {
                    final canGoPrevious = currentIndex > 0 ||
                        widget.scrollBehavior == CarouselScrollBehavior.loop;
                    final canGoNext = currentIndex < widget.itemCount - 1 ||
                        widget.scrollBehavior == CarouselScrollBehavior.loop;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Previous button
                        Semantics(
                          enabled: canGoPrevious,
                          label: 'Previous item',
                          button: true,
                          child: _buildNavButton(
                            icon: theme?.carouselStyle.previousIcon ??
                                Icons.arrow_back,
                            onPressed: canGoPrevious ? _goPrevious : null,
                            size: navButtonSize,
                          ),
                        ),
                        // Index indicator
                        Semantics(
                          label: 'Item ${currentIndex + 1} of ${widget.itemCount}',
                          child: AppText(
                            '${currentIndex + 1} / ${widget.itemCount}',
                            variant: AppTextVariant.bodySmall,
                          ),
                        ),
                        // Next button
                        Semantics(
                          enabled: canGoNext,
                          label: 'Next item',
                          button: true,
                          child: _buildNavButton(
                            icon: theme?.carouselStyle.nextIcon ??
                                Icons.arrow_forward,
                            onPressed: canGoNext ? _goNext : null,
                            size: navButtonSize,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required double size,
  }) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final navButtonColor = theme?.carouselStyle.navButtonColor ?? Colors.grey;

    return Opacity(
      opacity: onPressed != null ? 1.0 : 0.5,
      child: AppSurface(
        variant: SurfaceVariant.elevated,
        interactive: onPressed != null,
        onTap: onPressed,
        width: size,
        height: size,
        padding: EdgeInsets.zero,
        child: Center(
          child: Icon(
            icon,
            color: onPressed != null ? navButtonColor : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }
}

// Enum for carousel scroll behavior
enum CarouselScrollBehavior {
  smooth, // Smooth animation between items
  snap, // Instant snap to next item (Pixel theme)
  loop, // Loop back to start after last item
}
