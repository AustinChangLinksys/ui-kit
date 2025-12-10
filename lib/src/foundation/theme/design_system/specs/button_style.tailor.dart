// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppButtonStyleTailorMixin on ThemeExtension<AppButtonStyle> {
  ButtonSurfaceStates get filledSurfaces;
  StateColorSpec get filledContentColors;
  ButtonSurfaceStates get outlineSurfaces;
  StateColorSpec get outlineContentColors;
  ButtonSurfaceStates get textSurfaces;
  StateColorSpec get textContentColors;
  ButtonTextStyles get textStyles;
  ButtonSizeSpec get sizeSpec;
  InteractionSpec get interaction;

  @override
  AppButtonStyle copyWith({
    ButtonSurfaceStates? filledSurfaces,
    StateColorSpec? filledContentColors,
    ButtonSurfaceStates? outlineSurfaces,
    StateColorSpec? outlineContentColors,
    ButtonSurfaceStates? textSurfaces,
    StateColorSpec? textContentColors,
    ButtonTextStyles? textStyles,
    ButtonSizeSpec? sizeSpec,
    InteractionSpec? interaction,
  }) {
    return AppButtonStyle(
      filledSurfaces: filledSurfaces ?? this.filledSurfaces,
      filledContentColors: filledContentColors ?? this.filledContentColors,
      outlineSurfaces: outlineSurfaces ?? this.outlineSurfaces,
      outlineContentColors: outlineContentColors ?? this.outlineContentColors,
      textSurfaces: textSurfaces ?? this.textSurfaces,
      textContentColors: textContentColors ?? this.textContentColors,
      textStyles: textStyles ?? this.textStyles,
      sizeSpec: sizeSpec ?? this.sizeSpec,
      interaction: interaction ?? this.interaction,
    );
  }

  @override
  AppButtonStyle lerp(
      covariant ThemeExtension<AppButtonStyle>? other, double t) {
    if (other is! AppButtonStyle) return this as AppButtonStyle;
    return AppButtonStyle(
      filledSurfaces: filledSurfaces.lerp(other.filledSurfaces, t),
      filledContentColors:
          filledContentColors.lerp(other.filledContentColors, t),
      outlineSurfaces: outlineSurfaces.lerp(other.outlineSurfaces, t),
      outlineContentColors:
          outlineContentColors.lerp(other.outlineContentColors, t),
      textSurfaces: textSurfaces.lerp(other.textSurfaces, t),
      textContentColors: textContentColors.lerp(other.textContentColors, t),
      textStyles: textStyles.lerp(other.textStyles, t),
      sizeSpec: sizeSpec.lerp(other.sizeSpec, t),
      interaction: t < 0.5 ? interaction : other.interaction,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppButtonStyle &&
            const DeepCollectionEquality()
                .equals(filledSurfaces, other.filledSurfaces) &&
            const DeepCollectionEquality()
                .equals(filledContentColors, other.filledContentColors) &&
            const DeepCollectionEquality()
                .equals(outlineSurfaces, other.outlineSurfaces) &&
            const DeepCollectionEquality()
                .equals(outlineContentColors, other.outlineContentColors) &&
            const DeepCollectionEquality()
                .equals(textSurfaces, other.textSurfaces) &&
            const DeepCollectionEquality()
                .equals(textContentColors, other.textContentColors) &&
            const DeepCollectionEquality()
                .equals(textStyles, other.textStyles) &&
            const DeepCollectionEquality().equals(sizeSpec, other.sizeSpec) &&
            const DeepCollectionEquality()
                .equals(interaction, other.interaction));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(filledSurfaces),
      const DeepCollectionEquality().hash(filledContentColors),
      const DeepCollectionEquality().hash(outlineSurfaces),
      const DeepCollectionEquality().hash(outlineContentColors),
      const DeepCollectionEquality().hash(textSurfaces),
      const DeepCollectionEquality().hash(textContentColors),
      const DeepCollectionEquality().hash(textStyles),
      const DeepCollectionEquality().hash(sizeSpec),
      const DeepCollectionEquality().hash(interaction),
    );
  }
}

extension AppButtonStyleBuildContextProps on BuildContext {
  AppButtonStyle get appButtonStyle =>
      Theme.of(this).extension<AppButtonStyle>()!;

  /// Surface states for filled variant buttons.
  ///
  /// Defines how filled buttons (solid background) appear in different
  /// interaction states (enabled, disabled, hovered, pressed).
  ButtonSurfaceStates get filledSurfaces => appButtonStyle.filledSurfaces;

  /// Content colors for filled variant buttons.
  ///
  /// Defines text and icon colors for filled buttons across all states
  /// using StateColorSpec for consistent state management.
  StateColorSpec get filledContentColors => appButtonStyle.filledContentColors;

  /// Surface states for outline variant buttons.
  ///
  /// Defines how outline buttons (transparent background, visible border)
  /// appear in different interaction states.
  ButtonSurfaceStates get outlineSurfaces => appButtonStyle.outlineSurfaces;

  /// Content colors for outline variant buttons.
  ///
  /// Defines text and icon colors for outline buttons across all states
  /// using StateColorSpec for consistent state management.
  StateColorSpec get outlineContentColors =>
      appButtonStyle.outlineContentColors;

  /// Surface states for text variant buttons.
  ///
  /// Defines how text buttons (no background or border) appear in
  /// different interaction states.
  ButtonSurfaceStates get textSurfaces => appButtonStyle.textSurfaces;

  /// Content colors for text variant buttons.
  ///
  /// Defines text and icon colors for text-only buttons across all states
  /// using StateColorSpec for consistent state management.
  StateColorSpec get textContentColors => appButtonStyle.textContentColors;

  /// Typography definitions for all button sizes.
  ///
  /// Provides consistent text styling across all button variants
  /// using Constitutional appTextTheme tokens.
  ButtonTextStyles get textStyles => appButtonStyle.textStyles;

  /// Size specifications for all button dimensions.
  ///
  /// Defines heights, padding, and spacing for small, medium, and large
  /// button sizes across all variants.
  ButtonSizeSpec get sizeSpec => appButtonStyle.sizeSpec;

  /// Interaction specifications for button animations and feedback.
  ///
  /// Defines how buttons respond to user interactions with consistent
  /// animation timing and visual feedback across the design system.
  InteractionSpec get interaction => appButtonStyle.interaction;
}
