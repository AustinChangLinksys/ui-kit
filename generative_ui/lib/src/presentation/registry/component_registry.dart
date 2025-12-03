import 'package:flutter/material.dart';

/// Builder function signature for component factories
///
/// Builds a Flutter widget from a component name and properties map.
/// No async operations are permitted in component builders.
///
/// Parameters:
/// - [context]: BuildContext for accessing theme and other context
/// - [props]: Map of properties to pass to the widget (typically from ToolUseBlock input)
///
/// Returns: A Flutter Widget instance
///
/// Example:
/// ```dart
/// typedef GenUiWidgetBuilder = Widget Function(
///   BuildContext context,
///   Map<String, dynamic> props,
/// );
///
/// GenUiWidgetBuilder wifiBuilder = (context, props) {
///   return WifiSettingsCard(
///     ssid: props['ssid'] as String? ?? 'Unknown',
///     security: props['security'] as String? ?? 'Open',
///     isEnabled: props['isEnabled'] as bool? ?? false,
///   );
/// };
/// ```
typedef GenUiWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props,
);

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
/// registry.register('WifiSettingsCard', (context, props) {
///   return WifiSettingsCard(
///     ssid: props['ssid'] as String? ?? 'Unknown',
///     security: props['security'] as String? ?? 'Open',
///     isEnabled: props['isEnabled'] as bool? ?? false,
///   );
/// });
///
/// // Lookup during rendering
/// final builder = registry.lookup('WifiSettingsCard');
/// if (builder != null) {
///   final widget = builder(context, toolUseProps);
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
