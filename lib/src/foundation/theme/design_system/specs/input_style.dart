import 'package:equatable/equatable.dart';
import 'surface_style.dart';

/// Defines four basic variants and state modifiers for input fields.
class InputStyle extends Equatable {
  // Basic variants (determined by AppTextField.variant)
  final SurfaceStyle outlineStyle;
  final SurfaceStyle underlineStyle;
  final SurfaceStyle filledStyle;

  // State modifiers (determined by AppTextField internal state, overlaid when Focused)
  final SurfaceStyle focusModifier;
  final SurfaceStyle errorModifier;

  const InputStyle({
    required this.outlineStyle,
    required this.underlineStyle,
    required this.filledStyle,
    required this.focusModifier,
    required this.errorModifier,
  });

  InputStyle copyWith({
    SurfaceStyle? outlineStyle,
    SurfaceStyle? underlineStyle,
    SurfaceStyle? filledStyle,
    SurfaceStyle? focusModifier,
    SurfaceStyle? errorModifier,
  }) {
    return InputStyle(
      outlineStyle: outlineStyle ?? this.outlineStyle,
      underlineStyle: underlineStyle ?? this.underlineStyle,
      filledStyle: filledStyle ?? this.filledStyle,
      focusModifier: focusModifier ?? this.focusModifier,
      errorModifier: errorModifier ?? this.errorModifier,
    );
  }

  @override
  List<Object?> get props => [
        outlineStyle,
        underlineStyle,
        filledStyle,
        focusModifier,
        errorModifier,
      ];
}
