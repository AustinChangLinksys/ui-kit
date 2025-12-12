import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration class for page bottom action bar display and behavior
///
/// This class follows UI Kit constitutional compliance by using Equatable
/// for value equality and providing immutable configuration options.
class PageBottomBarConfig extends Equatable {
  /// Label for the positive/primary action button
  final String? positiveLabel;

  /// Label for the negative/secondary action button
  final String? negativeLabel;

  /// Callback for positive action button tap
  final VoidCallback? onPositiveTap;

  /// Callback for negative action button tap
  final VoidCallback? onNegativeTap;

  /// Whether the positive action button is enabled
  final bool isPositiveEnabled;

  /// Whether the negative action button is enabled
  final bool? isNegativeEnabled;

  /// Whether the positive action represents a destructive operation
  final bool isDestructive;

  /// Creates a new PageBottomBarConfig instance
  const PageBottomBarConfig({
    this.positiveLabel,
    this.negativeLabel,
    this.onPositiveTap,
    this.onNegativeTap,
    this.isPositiveEnabled = true,
    this.isNegativeEnabled,
    this.isDestructive = false,
  });

  /// Creates a copy of this config with the given fields replaced
  PageBottomBarConfig copyWith({
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
    bool? isPositiveEnabled,
    bool? isNegativeEnabled,
    bool? isDestructive,
  }) {
    return PageBottomBarConfig(
      positiveLabel: positiveLabel ?? this.positiveLabel,
      negativeLabel: negativeLabel ?? this.negativeLabel,
      onPositiveTap: onPositiveTap ?? this.onPositiveTap,
      onNegativeTap: onNegativeTap ?? this.onNegativeTap,
      isPositiveEnabled: isPositiveEnabled ?? this.isPositiveEnabled,
      isNegativeEnabled: isNegativeEnabled ?? this.isNegativeEnabled,
      isDestructive: isDestructive ?? this.isDestructive,
    );
  }

  @override
  List<Object?> get props => [
        positiveLabel,
        negativeLabel,
        onPositiveTap,
        onNegativeTap,
        isPositiveEnabled,
        isNegativeEnabled,
        isDestructive,
      ];

  @override
  bool get stringify => true;
}