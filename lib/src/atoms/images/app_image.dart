import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../foundation/gen/assets.gen.dart';
import 'dark_mode_mixin.dart';
import 'dark_mode_strategy.dart';

/// A unified image component supporting multiple sources with dark mode adaptation.
///
/// [AppImage] provides factory constructors for various image sources and
/// automatically handles dark mode theming through either:
/// 1. **Variant switching**: Provide a [darkVariant] to switch images in dark mode
/// 2. **Strategy filtering**: Apply a [DarkModeStrategy] to adapt images
/// 3. **Custom filtering**: Provide a [darkColorFilter] for full control
///
/// ## Usage Examples
///
/// ### From flutter_gen asset:
/// ```dart
/// AppImage.asset(
///   image: Assets.images.devices.routerMx6200,
///   darkStrategy: DarkModeStrategy.dimming,
/// )
/// ```
///
/// ### From network URL:
/// ```dart
/// AppImage.network(
///   url: 'https://example.com/image.png',
///   darkUrl: 'https://example.com/image_dark.png', // optional
///   placeholder: CircularProgressIndicator(),
/// )
/// ```
///
/// ### With dark variant:
/// ```dart
/// AppImage.asset(
///   image: Assets.images.banner,
///   darkVariant: Assets.images.bannerDark,
/// )
/// ```
class AppImage extends StatelessWidget with DarkModeAdaptation {
  /// Internal image provider for light mode / universal image.
  final ImageProvider _imageProvider;

  /// Internal image provider for dark mode (if provided).
  final ImageProvider? _darkImageProvider;

  /// Strategy for adapting image in dark mode when no dark variant is provided.
  final DarkModeStrategy darkStrategy;

  /// Custom color filter to apply in dark mode (overrides [darkStrategy]).
  final ColorFilter? darkColorFilter;

  /// Image width.
  final double? width;

  /// Image height.
  final double? height;

  /// How the image should be inscribed into the space allocated during layout.
  final BoxFit fit;

  /// Widget to display while the image is loading (for network/file sources).
  final Widget? placeholder;

  /// Widget to display if the image fails to load.
  final Widget? errorWidget;

  // ---------------------------------------------------------------------------
  // Private constructor (all factories delegate to this)
  // ---------------------------------------------------------------------------

  const AppImage._({
    required ImageProvider imageProvider,
    ImageProvider? darkImageProvider,
    this.darkStrategy = DarkModeStrategy.none,
    this.darkColorFilter,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    super.key,
  })  : _imageProvider = imageProvider,
        _darkImageProvider = darkImageProvider;

  // ---------------------------------------------------------------------------
  // Factory: asset (flutter_gen AssetGenImage)
  // ---------------------------------------------------------------------------

  /// Creates an [AppImage] from a flutter_gen [AssetGenImage].
  ///
  /// This is the preferred way to use assets from the UI Kit library.
  ///
  /// ```dart
  /// AppImage.asset(
  ///   image: Assets.images.devices.routerMx6200,
  ///   darkStrategy: DarkModeStrategy.dimming,
  /// )
  /// ```
  factory AppImage.asset({
    required AssetGenImage image,
    AssetGenImage? darkVariant,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Key? key,
  }) {
    return AppImage._(
      imageProvider: image.provider(package: 'ui_kit_library'),
      darkImageProvider: darkVariant?.provider(package: 'ui_kit_library'),
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

  /// Creates an [AppImage] from a network URL.
  ///
  /// ```dart
  /// AppImage.network(
  ///   url: 'https://example.com/image.png',
  ///   darkUrl: 'https://example.com/image_dark.png',
  ///   placeholder: CircularProgressIndicator(),
  /// )
  /// ```
  factory AppImage.network({
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
    double scale = 1.0,
    Key? key,
  }) {
    return AppImage._(
      imageProvider: NetworkImage(url, headers: headers, scale: scale),
      darkImageProvider: darkUrl != null
          ? NetworkImage(darkUrl, headers: headers, scale: scale)
          : null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Factory: file
  // ---------------------------------------------------------------------------

  /// Creates an [AppImage] from a local [File].
  ///
  /// ```dart
  /// AppImage.file(
  ///   file: File('/path/to/image.png'),
  ///   darkStrategy: DarkModeStrategy.dimming,
  /// )
  /// ```
  factory AppImage.file({
    required File file,
    File? darkFile,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    double scale = 1.0,
    Key? key,
  }) {
    return AppImage._(
      imageProvider: FileImage(file, scale: scale),
      darkImageProvider:
          darkFile != null ? FileImage(darkFile, scale: scale) : null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Factory: memory
  // ---------------------------------------------------------------------------

  /// Creates an [AppImage] from memory bytes ([Uint8List]).
  ///
  /// ```dart
  /// AppImage.memory(
  ///   bytes: imageBytes,
  ///   darkBytes: darkImageBytes,
  /// )
  /// ```
  factory AppImage.memory({
    required Uint8List bytes,
    Uint8List? darkBytes,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    double scale = 1.0,
    Key? key,
  }) {
    return AppImage._(
      imageProvider: MemoryImage(bytes, scale: scale),
      darkImageProvider:
          darkBytes != null ? MemoryImage(darkBytes, scale: scale) : null,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Factory: provider (most flexible)
  // ---------------------------------------------------------------------------

  /// Creates an [AppImage] from any [ImageProvider].
  ///
  /// This is the most flexible option for custom image sources.
  ///
  /// ```dart
  /// AppImage.provider(
  ///   imageProvider: AssetImage('assets/custom.png'),
  ///   darkImageProvider: AssetImage('assets/custom_dark.png'),
  /// )
  /// ```
  factory AppImage.provider({
    required ImageProvider imageProvider,
    ImageProvider? darkImageProvider,
    DarkModeStrategy darkStrategy = DarkModeStrategy.none,
    ColorFilter? darkColorFilter,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
    Key? key,
  }) {
    return AppImage._(
      imageProvider: imageProvider,
      darkImageProvider: darkImageProvider,
      darkStrategy: darkStrategy,
      darkColorFilter: darkColorFilter,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      key: key,
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    // 1. Determine which image provider to use
    final provider = (isDark && _darkImageProvider != null)
        ? _darkImageProvider
        : _imageProvider;

    // 2. Build the base image widget
    Widget imageWidget = Image(
      image: provider,
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.medium,
      frameBuilder: _buildFrame,
      errorBuilder: errorWidget != null ? _buildError : null,
    );

    // 3. Apply dark mode filter if needed (only when no dark variant is used)
    final hasVariant = isDark && _darkImageProvider != null;
    return applyDarkModeFilter(
      context: context,
      child: imageWidget,
      hasVariant: hasVariant,
      strategy: darkStrategy,
      customFilter: darkColorFilter,
    );
  }

  Widget _buildFrame(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded || frame != null) {
      return child;
    }
    // Show placeholder while loading
    return placeholder ??
        SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        );
  }

  Widget _buildError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return errorWidget ??
        SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        );
  }
}
