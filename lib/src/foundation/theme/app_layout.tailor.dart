// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_layout.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppLayoutTailorMixin on ThemeExtension<AppLayout> {
  double get breakpointMobile;
  double get breakpointTablet;
  double get breakpointDesktop;
  int get maxColumns;
  double get gutter;
  double get margin;

  @override
  AppLayout copyWith({
    double? breakpointMobile,
    double? breakpointTablet,
    double? breakpointDesktop,
    int? maxColumns,
    double? gutter,
    double? margin,
  }) {
    return AppLayout(
      breakpointMobile: breakpointMobile ?? this.breakpointMobile,
      breakpointTablet: breakpointTablet ?? this.breakpointTablet,
      breakpointDesktop: breakpointDesktop ?? this.breakpointDesktop,
      maxColumns: maxColumns ?? this.maxColumns,
      gutter: gutter ?? this.gutter,
      margin: margin ?? this.margin,
    );
  }

  @override
  AppLayout lerp(covariant ThemeExtension<AppLayout>? other, double t) {
    if (other is! AppLayout) return this as AppLayout;
    return AppLayout(
      breakpointMobile: t < 0.5 ? breakpointMobile : other.breakpointMobile,
      breakpointTablet: t < 0.5 ? breakpointTablet : other.breakpointTablet,
      breakpointDesktop: t < 0.5 ? breakpointDesktop : other.breakpointDesktop,
      maxColumns: t < 0.5 ? maxColumns : other.maxColumns,
      gutter: t < 0.5 ? gutter : other.gutter,
      margin: t < 0.5 ? margin : other.margin,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppLayout &&
            const DeepCollectionEquality()
                .equals(breakpointMobile, other.breakpointMobile) &&
            const DeepCollectionEquality()
                .equals(breakpointTablet, other.breakpointTablet) &&
            const DeepCollectionEquality()
                .equals(breakpointDesktop, other.breakpointDesktop) &&
            const DeepCollectionEquality()
                .equals(maxColumns, other.maxColumns) &&
            const DeepCollectionEquality().equals(gutter, other.gutter) &&
            const DeepCollectionEquality().equals(margin, other.margin));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(breakpointMobile),
      const DeepCollectionEquality().hash(breakpointTablet),
      const DeepCollectionEquality().hash(breakpointDesktop),
      const DeepCollectionEquality().hash(maxColumns),
      const DeepCollectionEquality().hash(gutter),
      const DeepCollectionEquality().hash(margin),
    );
  }
}

extension AppLayoutBuildContextProps on BuildContext {
  AppLayout get appLayout => Theme.of(this).extension<AppLayout>()!;
  double get breakpointMobile => appLayout.breakpointMobile;
  double get breakpointTablet => appLayout.breakpointTablet;
  double get breakpointDesktop => appLayout.breakpointDesktop;
  int get maxColumns => appLayout.maxColumns;
  double get gutter => appLayout.gutter;
  double get margin => appLayout.margin;
}
