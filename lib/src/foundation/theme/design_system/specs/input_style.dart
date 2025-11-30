import 'package:equatable/equatable.dart';
import 'surface_style.dart';

/// 定義輸入框的四種基礎變體與狀態修改器。
class InputStyle extends Equatable {
  // 基礎變體 (由 AppTextField.variant 決定)
  final SurfaceStyle outlineStyle;
  final SurfaceStyle underlineStyle;
  final SurfaceStyle filledStyle;

  // 狀態修改器 (由 AppTextField 內部狀態決定，Focus 時疊加)
  final SurfaceStyle focusModifier;
  final SurfaceStyle errorModifier;

  const InputStyle({
    required this.outlineStyle,
    required this.underlineStyle,
    required this.filledStyle,
    required this.focusModifier,
    required this.errorModifier,
  });

  @override
  List<Object?> get props => [
        outlineStyle,
        underlineStyle,
        filledStyle,
        focusModifier,
        errorModifier,
      ];
}
