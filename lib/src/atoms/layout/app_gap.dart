import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_spacing.dart';
import '../../foundation/theme/tokens/app_theme.dart';

class AppGap extends StatelessWidget {
  final double _rawSize;
  final bool _isGutter; // Mark if it is a Gutter

  // Base constructor (private)
  const AppGap._(this._rawSize, {bool isGutter = false})
      : _isGutter = isGutter;

  // --- Semantic Factories ---

  /// 2px * factor
  factory AppGap.xxs() => const AppGap._(AppSpacing.xxs);

  /// 4px * factor
  factory AppGap.xs() => const AppGap._(AppSpacing.xs);

  /// 8px * factor
  factory AppGap.sm() => const AppGap._(AppSpacing.sm);

  /// 12px * factor
  factory AppGap.md() => const AppGap._(AppSpacing.md);

  /// 16px * factor (Standard)
  factory AppGap.lg() => const AppGap._(AppSpacing.lg);

  /// 24px * factor
  factory AppGap.xl() => const AppGap._(AppSpacing.xl);

  /// 32px * factor
  factory AppGap.xxl() => const AppGap._(AppSpacing.xxl);

  /// 48px * factor
  factory AppGap.xxxl() => const AppGap._(AppSpacing.xxxl);

  /// Responsive Gutter
  /// Size determined by Theme.layoutSpec and automatically changes with screen width
  factory AppGap.gutter() => const AppGap._(0, isGutter: true);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    double size;

    if (_isGutter) {
      // 1. Gutter logic: read LayoutSpec from Theme
      // MediaQuery is needed here to determine breakpoints
      final screenWidth = MediaQuery.of(context).size.width;
      size = theme.layoutSpec.gutter(screenWidth);
    } else {
      // 2. General logic: base size * Spacing Factor
      // This makes the gap automatically larger in Brutal mode
      size = _rawSize * theme.spacingFactor;
    }

    return Gap(size);
  }
}
