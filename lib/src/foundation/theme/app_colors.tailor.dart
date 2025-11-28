// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_colors.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppColorsTailorMixin on ThemeExtension<AppColors> {
  Color get success;
  Color get onSuccess;
  Color get successContainer;
  Color get onSuccessContainer;
  Color get warning;
  Color get onWarning;
  Color get warningContainer;
  Color get onWarningContainer;

  @override
  AppColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
  }) {
    return AppColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this as AppColors;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppColors &&
            const DeepCollectionEquality().equals(success, other.success) &&
            const DeepCollectionEquality().equals(onSuccess, other.onSuccess) &&
            const DeepCollectionEquality()
                .equals(successContainer, other.successContainer) &&
            const DeepCollectionEquality()
                .equals(onSuccessContainer, other.onSuccessContainer) &&
            const DeepCollectionEquality().equals(warning, other.warning) &&
            const DeepCollectionEquality().equals(onWarning, other.onWarning) &&
            const DeepCollectionEquality()
                .equals(warningContainer, other.warningContainer) &&
            const DeepCollectionEquality()
                .equals(onWarningContainer, other.onWarningContainer));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(onSuccess),
      const DeepCollectionEquality().hash(successContainer),
      const DeepCollectionEquality().hash(onSuccessContainer),
      const DeepCollectionEquality().hash(warning),
      const DeepCollectionEquality().hash(onWarning),
      const DeepCollectionEquality().hash(warningContainer),
      const DeepCollectionEquality().hash(onWarningContainer),
    );
  }
}

extension AppColorsBuildContextProps on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  Color get success => appColors.success;
  Color get onSuccess => appColors.onSuccess;
  Color get successContainer => appColors.successContainer;
  Color get onSuccessContainer => appColors.onSuccessContainer;
  Color get warning => appColors.warning;
  Color get onWarning => appColors.onWarning;
  Color get warningContainer => appColors.warningContainer;
  Color get onWarningContainer => appColors.onWarningContainer;
}
