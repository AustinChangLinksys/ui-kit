import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum DividerPattern {
  solid,
  dashed,
  jagged,
}

class DividerStyle extends Equatable {
  final Color color;
  final Color? secondaryColor;
  final double thickness;
  final double indent;
  final double endIndent;
  final double glowStrength;
  final DividerPattern pattern;

  const DividerStyle({
    required this.color,
    this.secondaryColor,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.glowStrength = 0.0,
    this.pattern = DividerPattern.solid,
  });

  /// Create a copy of this DividerStyle with modified properties
  DividerStyle copyWith({
    Color? color,
    Color? secondaryColor,
    double? thickness,
    double? indent,
    double? endIndent,
    double? glowStrength,
    DividerPattern? pattern,
  }) {
    return DividerStyle(
      color: color ?? this.color,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      thickness: thickness ?? this.thickness,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
      glowStrength: glowStrength ?? this.glowStrength,
      pattern: pattern ?? this.pattern,
    );
  }

  @override
  List<Object?> get props => [
        color,
        secondaryColor,
        thickness,
        indent,
        endIndent,
        glowStrength,
        pattern,
      ];
}
