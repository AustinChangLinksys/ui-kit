// lib/src/foundation/theme/design_system/specs/interaction_spec.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Defines how a surface physically responds to user interaction.
class InteractionSpec extends Equatable {
  // Visual Feedback
  final double hoverOpacity;
  final double pressedOpacity;
  
  // Physical Deformation
  final double pressedScale; // For Glass (e.g., 0.95)
  final Offset pressedOffset; // For Brutal (e.g., Offset(2, 2))

  const InteractionSpec({
    this.hoverOpacity = 1.0,
    this.pressedOpacity = 1.0,
    this.pressedScale = 1.0, // 1.0 = No scale
    this.pressedOffset = Offset.zero, // Zero = No movement
  });

  @override
  List<Object?> get props => [
        hoverOpacity,
        pressedOpacity,
        pressedScale,
        pressedOffset,
      ];
}