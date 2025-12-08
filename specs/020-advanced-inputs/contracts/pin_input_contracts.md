# Pin Input Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'pin_input_style.tailor.dart';

enum PinCellShape {
  underline,
  box,
  circle,
  recess,
}

@TailorMixin()
class PinInputStyle extends ThemeExtension<PinInputStyle> with _$PinInputStyleTailorMixin {
  final PinCellShape cellShape;
  final bool fillOnInput;       // Pixel (Invert colors)
  final bool glowOnActive;      // Glass
  final TextStyle textStyle;    // Mono for Pixel
  final double cellSpacing;
  final double cellSize;

  PinInputStyle({
    required this.cellShape,
    required this.fillOnInput,
    required this.glowOnActive,
    required this.textStyle,
    required this.cellSpacing,
    required this.cellSize,
  });
}

class AppPinInput extends StatelessWidget {
  final int length; 
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool obscureText; 
  final bool autoFocus;
  final String? errorText;

  const AppPinInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscureText = false,
    this.autoFocus = false,
    this.errorText,
  });
}
```
