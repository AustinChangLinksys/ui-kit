import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/demo_components.dart';

/// Registers the WifiSettingsCard demo component with the registry.
///
/// This helper demonstrates how to map JSON properties to widget parameters.
void registerWifiSettingsCard(IComponentRegistry registry) {
  registry.register('WifiSettingsCard', (context, props) {
    return WifiSettingsCard(
      ssid: props['ssid'] as String? ?? 'Unknown',
      security: props['security'] as String? ?? 'Open',
      isEnabled: props['isEnabled'] as bool? ?? false,
    );
  });
}

/// Registers the InfoCard demo component with the registry.
void registerInfoCard(IComponentRegistry registry) {
  registry.register('InfoCard', (context, props) {
    return InfoCard(
      title: props['title'] as String? ?? 'Info',
      message: props['message'] as String? ?? '',
      iconName: props['icon'] as String?,
    );
  });
}
