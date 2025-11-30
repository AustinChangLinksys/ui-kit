import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_spacing.dart';
import '../../foundation/theme/tokens/app_theme.dart';

class AppGap extends StatelessWidget {
  final double _rawSize;
  final bool _isGutter; // 標記是否為 Gutter

  // 基礎建構子 (私有)
  const AppGap._(this._rawSize, {bool isGutter = false})
      : _isGutter = isGutter;

  // --- Semantic Factories (語義化建構子) ---

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

  /// ✨ 響應式 Gutter
  /// 大小由 Theme.layoutSpec 決定，並隨螢幕寬度自動變化
  factory AppGap.gutter() => const AppGap._(0, isGutter: true);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    double size;

    if (_isGutter) {
      // 1. Gutter 邏輯：讀取 Theme 中的 LayoutSpec
      // 這裡需要 MediaQuery 來決定斷點
      final screenWidth = MediaQuery.of(context).size.width;
      size = theme.layoutSpec.gutter(screenWidth);
    } else {
      // 2. 一般邏輯：基礎尺寸 * Spacing Factor
      // 這讓 Brutal 模式下的 gap 自動變大
      size = _rawSize * theme.spacingFactor;
    }

    return Gap(size);
  }
}
