import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Enum to represent available textures
enum TextureOption {
  none,
  pixelGrid,
  diagonalLines,
  noise,
  wood,
  metal,
  fabric,
  checkerboard,
  pixelArt,
}

/// Extension to get display names for textures
extension TextureOptionDisplay on TextureOption {
  String get displayName {
    switch (this) {
      case TextureOption.none:
        return 'None';
      case TextureOption.pixelGrid:
        return 'Pixel Grid';
      case TextureOption.diagonalLines:
        return 'Diagonal Lines';
      case TextureOption.noise:
        return 'Noise / Glass';
      case TextureOption.wood:
        return 'Wood';
      case TextureOption.metal:
        return 'Metal';
      case TextureOption.fabric:
        return 'Fabric';
      case TextureOption.checkerboard:
        return 'Checkerboard';
      case TextureOption.pixelArt:
        return 'Pixel Art (8-bit)';
    }
  }

  ImageProvider? get imageProvider {
    switch (this) {
      case TextureOption.none:
        return null;
      case TextureOption.pixelGrid:
        return AppTextures.pixelGrid;
      case TextureOption.diagonalLines:
        return AppTextures.diagonalLines;
      case TextureOption.noise:
        return AppTextures.noise;
      case TextureOption.wood:
        return AppTextures.wood;
      case TextureOption.metal:
        return AppTextures.metal;
      case TextureOption.fabric:
        return AppTextures.fabric;
      case TextureOption.checkerboard:
        return AppTextures.checkerboard;
      case TextureOption.pixelArt:
        return AppTextures.pixelArt;
    }
  }
}

/// Widget for selecting textures
class TextureProperty extends StatefulWidget {
  final String label;
  final TextureOption value;
  final ValueChanged<TextureOption> onChanged;

  const TextureProperty({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  State<TextureProperty> createState() => _TexturePropertyState();
}

class _TexturePropertyState extends State<TextureProperty> {
  late TextureOption _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(TextureProperty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              DropdownButton<TextureOption>(
                value: _selectedValue,
                items: TextureOption.values
                    .map(
                      (TextureOption option) => DropdownMenuItem<TextureOption>(
                        value: option,
                        child: Text(option.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (TextureOption? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    widget.onChanged(newValue);
                  }
                },
              ),
            ],
          ),
          if (_selectedValue != TextureOption.none) ...[
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade50,
              ),
              child: Image(
                image: _selectedValue.imageProvider!,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
