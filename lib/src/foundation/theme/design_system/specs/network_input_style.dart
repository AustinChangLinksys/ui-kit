import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SeparatorStyle {
  dot,
  glowingDot,
  squareBlock,
}

class NetworkInputStyle extends Equatable {
  final SeparatorStyle ipv4SeparatorStyle;
  final String macAddressSeparator;
  final TextStyle? separatorTextStyle;

  const NetworkInputStyle({
    required this.ipv4SeparatorStyle,
    required this.macAddressSeparator,
    this.separatorTextStyle,
  });

  @override
  List<Object?> get props => [
        ipv4SeparatorStyle,
        macAddressSeparator,
        separatorTextStyle,
      ];
}
