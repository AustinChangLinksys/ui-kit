import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/texture_property.dart';
import 'color_info_display.dart';

/// Editor widget for SurfaceStyle properties
/// Allows editing of all 11 SurfaceStyle parameters:
/// backgroundColor, borderColor, contentColor, borderWidth, borderRadius, customBorder, shadows, blurStrength, interaction, texture, textureOpacity
class SurfaceStyleEditor extends StatefulWidget {
  final String title;
  final SurfaceStyle initialStyle;
  final ValueChanged<SurfaceStyle> onChanged;

  const SurfaceStyleEditor({
    required this.title,
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<SurfaceStyleEditor> createState() => _SurfaceStyleEditorState();
}

class _SurfaceStyleEditorState extends State<SurfaceStyleEditor> {
  late SurfaceStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(SurfaceStyleEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(SurfaceStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleBorderWidthChanged(double value) {
    final updated = _currentStyle.copyWith(borderWidth: value);
    _updateStyle(updated);
  }

  void _handleBorderRadiusChanged(double value) {
    final updated = _currentStyle.copyWith(borderRadius: value);
    _updateStyle(updated);
  }

  void _handleBlurStrengthChanged(double value) {
    final updated = _currentStyle.copyWith(blurStrength: value);
    _updateStyle(updated);
  }

  void _handleTextureChanged(TextureOption option) {
    final updated = _currentStyle.copyWith(texture: option.imageProvider);
    _updateStyle(updated);
  }

  void _handleTextureOpacityChanged(double value) {
    final updated = _currentStyle.copyWith(textureOpacity: value);
    _updateStyle(updated);
  }

  TextureOption _getCurrentTextureOption() {
    if (_currentStyle.texture == null) {
      return TextureOption.none;
    }
    // Compare texture properties to determine which option is selected
    try {
      if (_currentStyle.texture == AppTextures.pixelGrid) {
        return TextureOption.pixelGrid;
      } else if (_currentStyle.texture == AppTextures.diagonalLines) {
        return TextureOption.diagonalLines;
      } else if (_currentStyle.texture == AppTextures.noise) {
        return TextureOption.noise;
      } else if (_currentStyle.texture == AppTextures.wood) {
        return TextureOption.wood;
      } else if (_currentStyle.texture == AppTextures.metal) {
        return TextureOption.metal;
      } else if (_currentStyle.texture == AppTextures.fabric) {
        return TextureOption.fabric;
      } else if (_currentStyle.texture == AppTextures.checkerboard) {
        return TextureOption.checkerboard;
      } else if (_currentStyle.texture == AppTextures.pixelArt) {
        return TextureOption.pixelArt;
      }
    } catch (_) {
      // If texture comparison fails, default to none
    }
    return TextureOption.none;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        '11 parameters',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Background Color - Read-only (managed via Colors tab)
              ColorInfoDisplay(
                label: 'Background Color',
                color: _currentStyle.backgroundColor,
                sourceColor: 'Set via theme implementation',
                note: 'Modify in Colors tab to change scheme colors',
              ),
              const Gap(16),

              // 2. Border Color - Read-only (managed via Colors tab)
              ColorInfoDisplay(
                label: 'Border Color',
                color: _currentStyle.borderColor,
                sourceColor: 'Set via theme implementation',
                note: 'Modify in Colors tab to change scheme colors',
              ),
              const Gap(16),

              // 3. Content Color - Read-only (managed via Colors tab)
              ColorInfoDisplay(
                label: 'Content Color (text/icons)',
                color: _currentStyle.contentColor,
                sourceColor: 'Set via theme implementation',
                note: 'Modify in Colors tab to change scheme colors',
              ),
              const Gap(16),

              // 4. Border Width
              DoubleProperty(
                label: 'Border Width',
                value: _currentStyle.borderWidth,
                min: 0,
                max: 10,
                onChanged: _handleBorderWidthChanged,
                divisions: 20,
              ),
              const Gap(16),

              // 5. Border Radius
              DoubleProperty(
                label: 'Border Radius',
                value: _currentStyle.borderRadius,
                min: 0,
                max: 32,
                onChanged: _handleBorderRadiusChanged,
                divisions: 32,
              ),
              const Gap(16),

              // 6. Blur Strength (for glass effect)
              DoubleProperty(
                label: 'Blur Strength',
                value: _currentStyle.blurStrength,
                min: 0,
                max: 50,
                onChanged: _handleBlurStrengthChanged,
                divisions: 50,
              ),
              const Gap(16),

              // 7. Shadows (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Box Shadows',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${_currentStyle.shadows.length} shadow(s)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      'Currently read-only. Shadows set via theme implementations.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // 8. Custom Border (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Border',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _currentStyle.customBorder != null ? 'Custom' : 'None',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      'Optional override for borderColor/borderWidth',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // 9. Interaction Spec (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interaction Spec',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _currentStyle.interaction != null ? 'Configured' : 'None',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      'Defines hover, press opacity, scale, and offset behavior',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // 10. Texture
              TextureProperty(
                label: 'Texture',
                value: _getCurrentTextureOption(),
                onChanged: _handleTextureChanged,
              ),
              const Gap(16),

              // 11. Texture Opacity
              if (_currentStyle.texture != null)
                DoubleProperty(
                  label: 'Texture Opacity',
                  value: _currentStyle.textureOpacity,
                  min: 0,
                  max: 1,
                  onChanged: _handleTextureOpacityChanged,
                  divisions: 100,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
