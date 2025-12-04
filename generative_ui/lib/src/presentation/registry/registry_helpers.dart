import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/demo_components.dart';

/// Registers the WifiSettingsCard demo component with the registry.
///
/// This helper demonstrates how to map JSON properties to widget parameters
/// and wire up the onAction callback for closed-loop interaction.
void registerWifiSettingsCard(IComponentRegistry registry) {
  registry.register('WifiSettingsCard', (context, props, {onAction}) {
    return WifiSettingsCard(
      ssid: props['ssid'] as String? ?? 'Unknown',
      security: props['security'] as String? ?? 'Open',
      isEnabled: props['isEnabled'] as bool? ?? false,
      onSave: onAction != null
          ? (data) => onAction({'action': 'save', ...data})
          : null,
      onCancel: onAction != null
          ? () => onAction({'action': 'cancel'})
          : null,
    );
  });
}

/// Registers the InfoCard demo component with the registry.
///
/// InfoCard is read-only and doesn't use the onAction callback.
void registerInfoCard(IComponentRegistry registry) {
  registry.register('InfoCard', (context, props, {onAction}) {
    return InfoCard(
      title: props['title'] as String? ?? 'Info',
      message: props['message'] as String? ?? '',
      iconName: props['icon'] as String?,
    );
  });
}

/// Registers the ConfirmationCard component with the registry.
void registerConfirmationCard(IComponentRegistry registry) {
  registry.register('ConfirmationCard', (context, props, {onAction}) {
    return ConfirmationCard(
      title: props['title'] as String? ?? 'Status',
      message: props['message'] as String? ?? '',
      isSuccess: props['isSuccess'] as bool? ?? true,
      onDismiss: onAction != null
          ? () => onAction({'action': 'dismiss'})
          : null,
    );
  });
}

/// Registers all demo components with the registry.
///
/// Call this during app initialization to enable all demo components.
void registerAllDemoComponents(IComponentRegistry registry) {
  registerWifiSettingsCard(registry);
  registerInfoCard(registry);
  registerConfirmationCard(registry);
}
