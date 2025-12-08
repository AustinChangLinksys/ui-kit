# Range Input Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'range_input_style.tailor.dart';

@TailorMixin()
class RangeInputStyle extends ThemeExtension<RangeInputStyle> with _$RangeInputStyleTailorMixin {
  final bool mergeContainers; // Flat (Unified Box) vs Glass (Separated)
  final Widget? customSeparator; // Pixel (ASCII Icon) vs Flat (Text)
  final Color activeBorderColor; // signalStrong vs primary
  final double spacing; // Gap between inputs

  RangeInputStyle({
    required this.mergeContainers,
    this.customSeparator,
    required this.activeBorderColor,
    required this.spacing,
  });
}

class AppRangeInput extends StatelessWidget {
  final TextEditingController? startController;
  final TextEditingController? endController;
  final String? startLabel;
  final String? endLabel;
  final String? errorText; 
  final String? Function(String start, String end)? validator;
  
  const AppRangeInput({
    super.key,
    this.startController,
    this.endController,
    this.startLabel,
    this.endLabel,
    this.errorText,
    this.validator,
  });
}
```
