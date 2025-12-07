// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$TableStyleTailorMixin on ThemeExtension<TableStyle> {
  Color? get headerBackground;
  Color get rowBackground;
  Color get gridColor;
  double get gridWidth;
  bool get showVerticalGrid;
  Color? get hoverRowBackground;
  Color? get hoverRowContentColor;
  EdgeInsetsGeometry get cellPadding;
  double get rowHeight;
  TextStyle get headerTextStyle;
  TextStyle get cellTextStyle;
  bool get invertRowOnHover;
  bool get glowRowOnHover;
  Duration get modeTransitionDuration;

  @override
  TableStyle copyWith({
    Color? headerBackground,
    Color? rowBackground,
    Color? gridColor,
    double? gridWidth,
    bool? showVerticalGrid,
    Color? hoverRowBackground,
    Color? hoverRowContentColor,
    EdgeInsetsGeometry? cellPadding,
    double? rowHeight,
    TextStyle? headerTextStyle,
    TextStyle? cellTextStyle,
    bool? invertRowOnHover,
    bool? glowRowOnHover,
    Duration? modeTransitionDuration,
  }) {
    return TableStyle(
      headerBackground: headerBackground ?? this.headerBackground,
      rowBackground: rowBackground ?? this.rowBackground,
      gridColor: gridColor ?? this.gridColor,
      gridWidth: gridWidth ?? this.gridWidth,
      showVerticalGrid: showVerticalGrid ?? this.showVerticalGrid,
      hoverRowBackground: hoverRowBackground ?? this.hoverRowBackground,
      hoverRowContentColor: hoverRowContentColor ?? this.hoverRowContentColor,
      cellPadding: cellPadding ?? this.cellPadding,
      rowHeight: rowHeight ?? this.rowHeight,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      invertRowOnHover: invertRowOnHover ?? this.invertRowOnHover,
      glowRowOnHover: glowRowOnHover ?? this.glowRowOnHover,
      modeTransitionDuration:
          modeTransitionDuration ?? this.modeTransitionDuration,
    );
  }

  @override
  TableStyle lerp(covariant ThemeExtension<TableStyle>? other, double t) {
    if (other is! TableStyle) return this as TableStyle;
    return TableStyle(
      headerBackground: Color.lerp(headerBackground, other.headerBackground, t),
      rowBackground: Color.lerp(rowBackground, other.rowBackground, t)!,
      gridColor: Color.lerp(gridColor, other.gridColor, t)!,
      gridWidth: t < 0.5 ? gridWidth : other.gridWidth,
      showVerticalGrid: t < 0.5 ? showVerticalGrid : other.showVerticalGrid,
      hoverRowBackground:
          Color.lerp(hoverRowBackground, other.hoverRowBackground, t),
      hoverRowContentColor:
          Color.lerp(hoverRowContentColor, other.hoverRowContentColor, t),
      cellPadding: t < 0.5 ? cellPadding : other.cellPadding,
      rowHeight: t < 0.5 ? rowHeight : other.rowHeight,
      headerTextStyle:
          TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      cellTextStyle: TextStyle.lerp(cellTextStyle, other.cellTextStyle, t)!,
      invertRowOnHover: t < 0.5 ? invertRowOnHover : other.invertRowOnHover,
      glowRowOnHover: t < 0.5 ? glowRowOnHover : other.glowRowOnHover,
      modeTransitionDuration:
          t < 0.5 ? modeTransitionDuration : other.modeTransitionDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TableStyle &&
            const DeepCollectionEquality()
                .equals(headerBackground, other.headerBackground) &&
            const DeepCollectionEquality()
                .equals(rowBackground, other.rowBackground) &&
            const DeepCollectionEquality().equals(gridColor, other.gridColor) &&
            const DeepCollectionEquality().equals(gridWidth, other.gridWidth) &&
            const DeepCollectionEquality()
                .equals(showVerticalGrid, other.showVerticalGrid) &&
            const DeepCollectionEquality()
                .equals(hoverRowBackground, other.hoverRowBackground) &&
            const DeepCollectionEquality()
                .equals(hoverRowContentColor, other.hoverRowContentColor) &&
            const DeepCollectionEquality()
                .equals(cellPadding, other.cellPadding) &&
            const DeepCollectionEquality().equals(rowHeight, other.rowHeight) &&
            const DeepCollectionEquality()
                .equals(headerTextStyle, other.headerTextStyle) &&
            const DeepCollectionEquality()
                .equals(cellTextStyle, other.cellTextStyle) &&
            const DeepCollectionEquality()
                .equals(invertRowOnHover, other.invertRowOnHover) &&
            const DeepCollectionEquality()
                .equals(glowRowOnHover, other.glowRowOnHover) &&
            const DeepCollectionEquality()
                .equals(modeTransitionDuration, other.modeTransitionDuration));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(headerBackground),
      const DeepCollectionEquality().hash(rowBackground),
      const DeepCollectionEquality().hash(gridColor),
      const DeepCollectionEquality().hash(gridWidth),
      const DeepCollectionEquality().hash(showVerticalGrid),
      const DeepCollectionEquality().hash(hoverRowBackground),
      const DeepCollectionEquality().hash(hoverRowContentColor),
      const DeepCollectionEquality().hash(cellPadding),
      const DeepCollectionEquality().hash(rowHeight),
      const DeepCollectionEquality().hash(headerTextStyle),
      const DeepCollectionEquality().hash(cellTextStyle),
      const DeepCollectionEquality().hash(invertRowOnHover),
      const DeepCollectionEquality().hash(glowRowOnHover),
      const DeepCollectionEquality().hash(modeTransitionDuration),
    );
  }
}

extension TableStyleBuildContextProps on BuildContext {
  TableStyle get tableStyle => Theme.of(this).extension<TableStyle>()!;
  Color? get headerBackground => tableStyle.headerBackground;
  Color get rowBackground => tableStyle.rowBackground;
  Color get gridColor => tableStyle.gridColor;
  double get gridWidth => tableStyle.gridWidth;
  bool get showVerticalGrid => tableStyle.showVerticalGrid;
  Color? get hoverRowBackground => tableStyle.hoverRowBackground;
  Color? get hoverRowContentColor => tableStyle.hoverRowContentColor;
  EdgeInsetsGeometry get cellPadding => tableStyle.cellPadding;
  double get rowHeight => tableStyle.rowHeight;
  TextStyle get headerTextStyle => tableStyle.headerTextStyle;
  TextStyle get cellTextStyle => tableStyle.cellTextStyle;
  bool get invertRowOnHover => tableStyle.invertRowOnHover;
  bool get glowRowOnHover => tableStyle.glowRowOnHover;
  Duration get modeTransitionDuration => tableStyle.modeTransitionDuration;
}
