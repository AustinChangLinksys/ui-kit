/// Defines the three visual style variants for button appearance.
///
/// This enum represents the fundamental visual treatments that determine
/// how a button's background and borders are rendered across all themes.
enum ButtonStyleVariant {
  /// Filled style variant with solid background color.
  ///
  /// Used for primary actions and high-emphasis interactions. The button
  /// renders with a solid background color from the theme's color scheme.
  ///
  /// Example usage:
  /// ```dart
  /// AppButton(
  ///   label: "Save",
  ///   variant: ButtonStyleVariant.filled,
  ///   onTap: () => save(),
  /// )
  /// ```
  filled,

  /// Outline style variant with transparent background and visible border.
  ///
  /// Used for secondary actions and medium-emphasis interactions. The button
  /// renders with a transparent background and a colored border.
  ///
  /// Example usage:
  /// ```dart
  /// AppButton(
  ///   label: "Cancel",
  ///   variant: ButtonStyleVariant.outline,
  ///   onTap: () => cancel(),
  /// )
  /// ```
  outline,

  /// Text style variant with no background or border.
  ///
  /// Used for tertiary actions and low-emphasis interactions. The button
  /// renders as text-only with no background decoration.
  ///
  /// Example usage:
  /// ```dart
  /// AppButton(
  ///   label: "Skip",
  ///   variant: ButtonStyleVariant.text,
  ///   onTap: () => skip(),
  /// )
  /// ```
  text,
}