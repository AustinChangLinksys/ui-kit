import 'package:flutter/material.dart';

/// Callback signature for component actions.
///
/// When a user interacts with a dynamic UI component (e.g., clicks "Save"),
/// this callback is invoked with the action data.
///
/// Parameters:
/// - [data]: Map containing action type and any associated data
///
/// Example:
/// ```dart
/// onAction?.call({'action': 'save', 'ssid': 'MyNetwork', 'password': '***'});
/// ```
typedef GenUiActionCallback = void Function(Map<String, dynamic> data);

/// Builder function signature for component factories.
///
/// Builds a Flutter widget from a component name and properties map.
/// No async operations are permitted in component builders.
///
/// Parameters:
/// - [context]: BuildContext for accessing theme and other context
/// - [props]: Map of properties to pass to the widget (typically from ToolUseBlock input)
/// - [onAction]: Optional callback for reporting user actions back to the AI
///
/// Returns: A Flutter Widget instance
///
/// Example:
/// ```dart
/// GenUiWidgetBuilder wifiBuilder = (context, props, {onAction}) {
///   return WifiSettingsCard(
///     ssid: props['ssid'] as String? ?? 'Unknown',
///     security: props['security'] as String? ?? 'Open',
///     isEnabled: props['isEnabled'] as bool? ?? false,
///     onSave: onAction != null
///         ? (data) => onAction({'action': 'save', ...data})
///         : null,
///     onCancel: onAction != null
///         ? () => onAction({'action': 'cancel'})
///         : null,
///   );
/// };
/// ```
typedef GenUiWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props, {
  GenUiActionCallback? onAction,
});

/// Interface for component registration and lookup
///
/// ComponentRegistry implements the Registry Pattern to decouple component
/// definition from rendering logic. Developers register UI Kit components
/// during app initialization, enabling GenUI to instantiate them dynamically.
///
/// Design guarantees:
/// - **O(1) lookup performance**: Hash-map based registry
/// - **Thread-safe registration**: Components can be registered during init phase
/// - **Fallback support**: Unknown components return null (handled by error boundary)
///
/// Usage example:
/// ```dart
/// final registry = ComponentRegistry();
///
/// // Register components during app initialization
/// registry.register('WifiSettingsCard', (context, props, {onAction}) {
///   return WifiSettingsCard(
///     ssid: props['ssid'] as String? ?? 'Unknown',
///     security: props['security'] as String? ?? 'Open',
///     isEnabled: props['isEnabled'] as bool? ?? false,
///     onSave: onAction != null
///         ? (data) => onAction({'action': 'save', ...data})
///         : null,
///   );
/// });
///
/// // Lookup and build with action callback
/// final builder = registry.lookup('WifiSettingsCard');
/// if (builder != null) {
///   final widget = builder(
///     context,
///     toolUseProps,
///     onAction: (data) => handleToolAction(toolUseId, data),
///   );
/// }
/// ```
abstract class IComponentRegistry {
  /// Register a component builder by name
  ///
  /// Once registered, a component can be looked up by name during rendering.
  /// Multiple registrations with the same name will override previous registrations.
  ///
  /// Parameters:
  /// - [componentName]: Unique identifier for the component (typically matches component class name)
  /// - [builder]: Factory function that builds the widget given context and props
  void register(String componentName, GenUiWidgetBuilder builder);

  /// Lookup a component builder by name
  ///
  /// O(1) performance guaranteed. Returns null if component not found.
  ///
  /// Parameters:
  /// - [componentName]: Name of the component to look up
  ///
  /// Returns: GenUiWidgetBuilder if found, null if not registered
  GenUiWidgetBuilder? lookup(String componentName);

  /// Get all registered component names
  ///
  /// Useful for debugging and introspection. Returns list of all component
  /// names currently registered in this instance.
  ///
  /// Returns: List of registered component names
  List<String> getRegisteredComponents();
}

/// Default implementation of ComponentRegistry
///
/// Provides O(1) lookup using a HashMap for component factory storage.
/// Thread-safe for registration during init phase.
class ComponentRegistry implements IComponentRegistry {
  final Map<String, GenUiWidgetBuilder> _registry = {};

  @override
  void register(String componentName, GenUiWidgetBuilder builder) {
    _registry[componentName] = builder;
  }

  @override
  GenUiWidgetBuilder? lookup(String componentName) {
    return _registry[componentName];
  }

  @override
  List<String> getRegisteredComponents() {
    return _registry.keys.toList();
  }
}
