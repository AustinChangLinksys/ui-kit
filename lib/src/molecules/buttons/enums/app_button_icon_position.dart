/// Icon position variants for buttons with icons.
///
/// Controls the placement of icons relative to button text for enhanced
/// visual layout and interaction patterns.
enum AppButtonIconPosition {
  /// Icon appears before the text (left side in LTR layouts).
  ///
  /// This is the most common pattern, following standard UI conventions
  /// where icons precede their associated text labels.
  leading,

  /// Icon appears after the text (right side in LTR layouts).
  ///
  /// Used for actions that suggest forward motion or continuation,
  /// such as "Next", "Continue", or "Submit" actions.
  trailing,
}