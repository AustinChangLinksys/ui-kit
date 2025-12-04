/// Gen UI Client - Layout Architect
///
/// AI-powered UI design tool with theme-aware dynamic components.
///
/// Features:
/// - Theme-aware rendering with 5 design languages (Glass, Brutal, Flat, Neumorphic, Pixel)
/// - Complete UI Kit component registry (31 components)
/// - Seed color customization with Material 3
/// - System prompt injection for AI context
///
/// Usage:
/// ```dart
/// import 'package:gen_ui_client/gen_ui_client.dart';
///
/// // Register UI Kit components
/// final registry = ComponentRegistry();
/// UiKitComponentRegistry.registerAll(registry);
///
/// // Use the pre-configured view
/// GenUiChatView(
///   registry: registry,
///   generator: myGenerator,
///   tools: UiKitComponentRegistry.createToolDefinitions(),
/// )
/// ```
library gen_ui_client;

// Core entities
export 'domain/entities/design_language.dart';
export 'domain/entities/layout_node.dart';
export 'domain/entities/theme_state.dart';

// Core errors
export 'core/errors/contract_exception.dart';
export 'core/errors/failure.dart';

// Core constants
export 'core/constants/theme_factories.dart';

// Presentation - Providers
export 'presentation/providers/theme_provider.dart';

// Presentation - Registry
export 'presentation/registry/component_builder.dart';
export 'presentation/registry/ui_kit_component_registry.dart';

// Presentation - Views
export 'presentation/views/architect_view.dart';
