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
