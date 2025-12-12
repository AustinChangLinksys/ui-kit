import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration for a custom menu view panel.
///
/// Used to display a custom widget (like a user profile panel)
/// in the sidebar area or as a BottomSheet trigger.
class PageMenuView extends Equatable {
  /// Icon to represent this menu view (used in list or trigger button)
  final IconData icon;

  /// Label for this menu view (used in list or accessibility)
  final String label;

  /// The actual content widget to display
  final Widget content;

  const PageMenuView({
    required this.icon,
    required this.label,
    required this.content,
  });

  @override
  List<Object?> get props => [icon, label, content];
}
