import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ui_kit_library/ui_kit.dart'; // 引入 AppTheme 等

/// Definition for the settings the addon will manage
@immutable
class DesignSystemSetting {
  final String designLanguage;
  final Color seedColor;

  const DesignSystemSetting({
    required this.designLanguage,
    required this.seedColor,
  });

  // Helper to create a new setting from field values (used by Widgetbook's internal UI)
  DesignSystemSetting copyWith({
    String? designLanguage,
    Color? seedColor,
  }) {
    return DesignSystemSetting(
      designLanguage: designLanguage ?? this.designLanguage,
      seedColor: seedColor ?? this.seedColor,
    );
  }

  // Comparison for equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DesignSystemSetting &&
        other.designLanguage == designLanguage &&
        other.seedColor == seedColor;
  }

  @override
  int get hashCode => designLanguage.hashCode ^ seedColor.hashCode;
}

// The custom Widgetbook Addon
class DesignSystemAddon extends WidgetbookAddon<DesignSystemSetting> {
  DesignSystemAddon()
      : super(
          name: 'Design System',
        );

  @override
  List<Field> get fields => [
        ObjectDropdownField<String>(
          // ListField is deprecated, use ObjectDropdownField instead.
          name: 'design',
          values: const [
            'Glass',
            'Brutal',
            'Flat',
            'Neumorphic',
          ],
          initialValue: 'Glass',
        ),
        ColorField(
          name: 'color',
          initialValue: const Color(0xFF0870EA),
        ),
      ];

  // This method is called by Widgetbook to convert query parameters back into a setting
  @override
  DesignSystemSetting valueFromQueryGroup(Map<String, String> group) {
    final design = valueOf('design', group);
    final color = valueOf('color', group);
    return DesignSystemSetting(
      designLanguage: design,
      seedColor: color,
    );
  }

  // This method builds the wrapper widget for use cases based on the current setting.
  @override
  Widget buildUseCase(
      BuildContext context, Widget child, DesignSystemSetting setting) {
    // 1. Get brightness from MaterialThemeAddon (via Theme.of(context))
    final brightness = Theme.of(context).brightness;

    // 2. Select Design System based on addon setting
    DesignThemeBuilder designThemeBuilder;

    switch (setting.designLanguage) {
      case 'Glass':
        designThemeBuilder = (scheme) => brightness == Brightness.light
            ? GlassDesignTheme.light(scheme)
            : GlassDesignTheme.dark(scheme);
        break;
      case 'Brutal':
        designThemeBuilder = (scheme) => brightness == Brightness.light
            ? BrutalDesignTheme.light(scheme)
            : BrutalDesignTheme.dark(scheme);
        break;

      case 'Neumorphic':
        designThemeBuilder = (scheme) => brightness == Brightness.light
            ? NeumorphicDesignTheme.light(scheme)
            : NeumorphicDesignTheme.dark(scheme);
        break;
      case 'Flat':
      default:
        designThemeBuilder = (scheme) => brightness == Brightness.light
            ? FlatDesignTheme.light(scheme)
            : FlatDesignTheme.dark(scheme);
        break;
    }

    // 3. Construct full theme
    final theme = AppTheme.create(
      brightness: brightness,
      seedColor: setting.seedColor,
      designThemeBuilder: designThemeBuilder,
    );

    // 4. Return MaterialApp with the constructed theme
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: theme.brightness == Brightness.light
            ? const Color(0xFFF0F2F5)
            : const Color(0xFF121212),
        body: Center(child: child),
      ),
    );
  }
}
