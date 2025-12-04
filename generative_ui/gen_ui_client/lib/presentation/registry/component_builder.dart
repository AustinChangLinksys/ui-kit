import 'package:flutter/widgets.dart';

/// Type definition for component builder functions.
///
/// Each builder receives:
/// - [context]: The build context for theme access
/// - [props]: Properties map from AI-generated layout
/// - [onAction]: Optional callback for interactive components
/// - [children]: Optional child widgets for container components
typedef ComponentBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props, {
  void Function(Map<String, dynamic>)? onAction,
  List<Widget>? children,
});
