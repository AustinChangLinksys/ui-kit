import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const defaultFullJson = """
{
  "primary": "#FF5733",
  "onPrimary": "#FFFFFF",
  "primaryContainer": "#FFC300",
  "onPrimaryContainer": "#000000",
  "secondary": "#33FF57",
  "onSecondary": "#FFFFFF",
  "secondaryContainer": "#C3FF00",
  "onSecondaryContainer": "#000000",
  "tertiary": "#3357FF",
  "onTertiary": "#FFFFFF",
  "tertiaryContainer": "#00C3FF",
  "onTertiaryContainer": "#000000",
  "error": "#FF0000",
  "onError": "#FFFFFF",
  "errorContainer": "#FFC0CB",
  "onErrorContainer": "#000000",
  "surface": "#F0F0F0",
  "onSurface": "#000000",
  "onSurfaceVariant": "#404040",
  "surfaceTint": "#FF5733",
  "surfaceContainer": "#E0E0E0",
  "surfaceContainerHigh": "#D0D0D0",
  "surfaceContainerHighest": "#C0C0C0",
  "surfaceContainerLow": "#F5F5F5",
  "surfaceContainerLowest": "#FAFAFA",
  "inverseSurface": "#303030",
  "onInverseSurface": "#FFFFFF",
  "inversePrimary": "#FFA07A",
  "outline": "#808080",
  "outlineVariant": "#B0B0B0",
  "shadow": "#000000",
  "scrim": "#000000",
  "highContrastBorder": "#000000",
  "subtleBorder": "#DDDDDD",
  "styleBackground": "#E0E0E0",
  "styleShadow": "#888888",
  "glowColor": "#FFD700",
  "semanticSuccess": "#00FF00",
  "semanticWarning": "#FFA500",
  "semanticDanger": "#FF0000",
  "semanticGlow": "#00FF00",
  "activeFillColor": "#FF5733",
  "activeContentColor": "#FFFFFF",
  "overlayColor": "#000000"
}
""";

@widgetbook.UseCase(
    name: 'Custom Theme via JSON', type: AppThemeConfigJsonViewer)
Widget buildColorJsonStory(BuildContext context) {
  return const Center(
    child: AppThemeConfigJsonViewer(
      initialJson: defaultFullJson,
    ),
  );
}

class AppThemeConfigJsonViewer extends StatefulWidget {
  final String initialJson;

  const AppThemeConfigJsonViewer({super.key, required this.initialJson});

  @override
  State<AppThemeConfigJsonViewer> createState() =>
      _AppThemeConfigJsonViewerState();
}

class _AppThemeConfigJsonViewerState extends State<AppThemeConfigJsonViewer> {
  late TextEditingController _jsonController;
  AppColorScheme? _currentScheme;
  String? _error;

  @override
  void initState() {
    super.initState();
    _jsonController = TextEditingController(text: widget.initialJson);
    _applyJson();
  }

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  void _applyJson() {
    setState(() {
      _error = null;
      try {
        _currentScheme =
            AppColorFactory.createSchemeFromJson(_jsonController.text);
      } catch (e) {
        _error = e.toString();
        _currentScheme = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = _currentScheme ??
        AppColorFactory.generateNeumorphic(const AppThemeConfig());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: _jsonController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                labelText: 'Custom Color Scheme JSON',
                border: const OutlineInputBorder(),
                errorText: _error,
              ),
              style: const TextStyle(fontFamily: 'Courier'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _applyJson,
            child: const Text('Apply JSON Theme'),
          ),
          const SizedBox(height: 16),
          Text(
            'Theme Preview',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ColorBox(color: scheme.primary, name: 'Primary'),
                  ColorBox(color: scheme.onPrimary, name: 'OnPrimary'),
                  ColorBox(
                      color: scheme.primaryContainer, name: 'PrimaryContainer'),
                  ColorBox(color: scheme.secondary, name: 'Secondary'),
                  ColorBox(color: scheme.onSecondary, name: 'OnSecondary'),
                  ColorBox(
                      color: scheme.secondaryContainer,
                      name: 'SecondaryContainer'),
                  ColorBox(color: scheme.tertiary, name: 'Tertiary'),
                  ColorBox(color: scheme.error, name: 'Error'),
                  ColorBox(color: scheme.surface, name: 'Surface'),
                  ColorBox(color: scheme.onSurface, name: 'OnSurface'),
                  ColorBox(
                      color: scheme.surfaceContainer, name: 'SurfaceContainer'),
                  ColorBox(
                      color: scheme.highContrastBorder,
                      name: 'HighContrastBorder'),
                  ColorBox(color: scheme.subtleBorder, name: 'SubtleBorder'),
                  ColorBox(
                      color: scheme.styleBackground, name: 'StyleBackground'),
                  ColorBox(color: scheme.styleShadow, name: 'StyleShadow'),
                  ColorBox(color: scheme.glowColor, name: 'GlowColor'),
                  ColorBox(
                      color: scheme.semanticSuccess, name: 'SemanticSuccess'),
                  ColorBox(
                      color: scheme.semanticWarning, name: 'SemanticWarning'),
                  ColorBox(
                      color: scheme.semanticDanger, name: 'SemanticDanger'),
                  ColorBox(
                      color: scheme.activeFillColor, name: 'ActiveFillColor'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;
  final String name;

  const ColorBox({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
