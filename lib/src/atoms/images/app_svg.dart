import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../foundation/gen/assets.gen.dart';
import 'dark_mode_mixin.dart';
import 'dark_mode_strategy.dart';

/// A unified SVG component supporting multiple sources with dark mode adaptation.
///
/// [AppSvg] provides factory constructors for various SVG sources and
/// automatically handles dark mode theming through either:
/// 1. **Variant switching**: Provide a [darkVariant] to switch SVGs in dark mode
/// 2. **Strategy filtering**: Apply a [DarkModeStrategy] to adapt SVGs
/// 3. **Custom filtering**: Provide a [darkColorFilter] for full control
///
/// ## Usage Examples
///
/// ### From flutter_gen asset:
/// ```dart
/// AppSvg.asset(
///   svg: Assets.images.icon,
///   darkStrategy: DarkModeStrategy.invert,
/// )
/// ```
///
/// ### From network URL:
/// ```dart
/// AppSvg.network(
///   url: 'https://example.com/icon.svg',
///   placeholder: CircularProgressIndicator(),
/// )
/// ```
///
/// ### From SVG string:
/// ```dart
/// AppSvg.string(
///   svgString: '<svg>...</svg>',
///   darkSvgString: '<svg>...</svg>', // optional
/// )
/// ```
class AppSvg extends StatelessWidget with DarkModeAdaptation {
  /// Builder function for the SVG widget (handles different sources).
  final Widget Function(BuildContext context, bool isDark) _builder;

  /// Strategy for adapting SVG in dark mode when no dark variant is provided.
  final DarkModeStrategy darkStrategy;

  /// Custom color filter to apply in dark mode (overrides [darkStrategy]).
  final ColorFilter? darkColorFilter;

  /// SVG width.
  final double? width;

  /// SVG height.
  final double? height;

  /// How the SVG should be inscribed into the space allocated during layout.
  final BoxFit fit;

  /// Whether a dark variant is provided.
  final bool _hasVariant;

  // ---------------------------------------------------------------------------
  // Private constructor
  // ---------------------------------------------------------------------------

  const AppSvg._({
    required Widget Function(BuildContext context, bool isDark) builder,
    required bool hasVariant,
    this.darkStrategy = DarkModeStrategy.none,
    this.darkColorFilter,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    super.key,
  })  : _builder = builder,
        _hasVariant = hasVariant;

  // ---------------------------------------------------------------------------
  // Factory: asset (flutter_gen SvgGenImage)
  // ---------------------------------------------------------------------------

  /// Creates an [AppSvg] from a flutter_gen [SvgGenImage].
  ///
  /// This is the preferred way to use SVG assets from the UI Kit library.
  ///
  /// ```dart
  /// AppSvg.asset(
  ///   svg: Assets.images.icon,
  ///   darkStrategy: DarkModeStrategy.invert,
  /// )
  /// ```
  factory AppSvg.asset({
    required SvgGenImage svg,
    SvgGenImage? darkVariant,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Key? key,
  }) {
    return AppSvg._(
      builder: (context, isDark) {
        final targetSvg = (isDark && darkVariant != null) ? darkVariant : svg;
        return targetSvg.svg(
          width: width,
          height: height,
          fit: fit,
        );
      },
      hasVariant: darkVariant != null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Factory: network
  // ---------------------------------------------------------------------------

  /// Creates an [AppSvg] from a network URL.
  ///
  /// ```dart
  /// AppSvg.network(
  ///   url: 'https://example.com/icon.svg',
  ///   darkUrl: 'https://example.com/icon_dark.svg',
  ///   placeholder: CircularProgressIndicator(),
  /// )
  /// ```
  factory AppSvg.network({
    required String url,
    String? darkUrl,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
    Map<String, String>? headers,
    Key? key,
  }) {
    return AppSvg._(
      builder: (context, isDark) {
        final targetUrl = (isDark && darkUrl != null) ? darkUrl : url;
        return SvgPicture.network(
          targetUrl,
          width: width,
          height: height,
          fit: fit,
          headers: headers,
          placeholderBuilder: placeholder != null ? (_) => placeholder : null,
          errorBuilder: errorWidget != null
              ? (_, __, ___) => errorWidget
              : (_, __, ___) => _buildDefaultError(width, height),
        );
      },
      hasVariant: darkUrl != null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // NOTE: AppSvg.file() was removed because dart:io is not supported on Web.
  // Use AppSvg.memory() or AppSvg.string() as alternatives for Web-compatible
  // local file loading.

  // ---------------------------------------------------------------------------
  // Factory: memory
  // ---------------------------------------------------------------------------

  /// Creates an [AppSvg] from memory bytes ([Uint8List]).
  ///
  /// ```dart
  /// AppSvg.memory(
  ///   bytes: svgBytes,
  ///   darkBytes: darkSvgBytes,
  /// )
  /// ```
  factory AppSvg.memory({
    required Uint8List bytes,
    Uint8List? darkBytes,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Key? key,
  }) {
    return AppSvg._(
      builder: (context, isDark) {
        final targetBytes = (isDark && darkBytes != null) ? darkBytes : bytes;
        return SvgPicture.memory(
          targetBytes,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: placeholder != null ? (_) => placeholder : null,
        );
      },
      hasVariant: darkBytes != null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Factory: string
  // ---------------------------------------------------------------------------

  /// Creates an [AppSvg] from an SVG string.
  ///
  /// ```dart
  /// AppSvg.string(
  ///   svgString: '<svg viewBox="0 0 24 24">...</svg>',
  ///   darkSvgString: '<svg viewBox="0 0 24 24">...</svg>',
  /// )
  /// ```
  factory AppSvg.string({
    required String svgString,
    String? darkSvgString,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Key? key,
  }) {
    return AppSvg._(
      builder: (context, isDark) {
        final targetString =
            (isDark && darkSvgString != null) ? darkSvgString : svgString;
        return SvgPicture.string(
          targetString,
          width: width,
          height: height,
          fit: fit,
        );
      },
      hasVariant: darkSvgString != null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    // 1. Build the SVG widget using the builder
    Widget svgWidget = _builder(context, isDark);

    // 2. Apply dark mode filter if needed (only when no dark variant is used)
    final hasVariant = isDark && _hasVariant;
    return applyDarkModeFilter(
      context: context,
      child: svgWidget,
      hasVariant: hasVariant,
      strategy: darkStrategy,
      customFilter: darkColorFilter,
    );
  }

  static Widget _buildDefaultError(double? width, double? height) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(
        child: Icon(Icons.broken_image_outlined, color: Colors.grey),
      ),
    );
  }
}
