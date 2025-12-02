import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Generates Dart code for the current theme
class CodeGenerator {
  static String generateDartCode(AppDesignTheme theme) {
    final buffer = StringBuffer();

    buffer.writeln('import \'package:ui_kit_library/ui_kit.dart\';');
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln('');
    buffer.writeln('/// Generated theme configuration');
    buffer.writeln('final customTheme = GlassDesignTheme.light(');
    buffer.writeln('  ColorScheme.fromSeed(');
    buffer.writeln('    seedColor: const Color(0xFF0870EA),');
    buffer.writeln('    brightness: Brightness.light,');
    buffer.writeln('  ),');
    buffer.writeln(').copyWith(');
    buffer.writeln('  spacingFactor: ${theme.spacingFactor},');
    buffer.writeln('  surfaceBase: ${_serializeSurfaceStyle(theme.surfaceBase)},');
    buffer.writeln('  surfaceElevated: ${_serializeSurfaceStyle(theme.surfaceElevated)},');
    buffer.writeln('  surfaceHighlight: ${_serializeSurfaceStyle(theme.surfaceHighlight)},');
    buffer.writeln('  inputStyle: ${_serializeInputStyle(theme.inputStyle)},');
    buffer.writeln('  toggleStyle: ${_serializeToggleStyle(theme.toggleStyle)},');
    buffer.writeln('  navigationStyle: ${_serializeNavigationStyle(theme.navigationStyle)},');
    buffer.writeln('  loaderStyle: ${_serializeLoaderStyle(theme.loaderStyle)},');
    buffer.writeln(');');

    return buffer.toString();
  }

  static String _colorToString(Color color) {
    return 'Color(0x${color.value.toRadixString(16).padLeft(8, '0')})';
  }

  static String _serializeSurfaceStyle(SurfaceStyle style) {
    return 'SurfaceStyle('
        'backgroundColor: ${_colorToString(style.backgroundColor)},'
        'borderColor: ${_colorToString(style.borderColor)},'
        'borderWidth: ${style.borderWidth},'
        'borderRadius: ${style.borderRadius},'
        'blurStrength: ${style.blurStrength},'
        'contentColor: ${_colorToString(style.contentColor)}'
        ')';
  }

  static String _serializeInputStyle(InputStyle style) {
    return 'InputStyle('
        'outlineStyle: ${_serializeSurfaceStyle(style.outlineStyle)},'
        'underlineStyle: ${_serializeSurfaceStyle(style.underlineStyle)},'
        'filledStyle: ${_serializeSurfaceStyle(style.filledStyle)},'
        'focusModifier: ${_serializeSurfaceStyle(style.focusModifier)},'
        'errorModifier: ${_serializeSurfaceStyle(style.errorModifier)}'
        ')';
  }

  static String _serializeToggleStyle(ToggleStyle style) {
    final activeTrack = style.activeTrackStyle != null
        ? _serializeSurfaceStyle(style.activeTrackStyle!)
        : 'null';
    final inactiveTrack = style.inactiveTrackStyle != null
        ? _serializeSurfaceStyle(style.inactiveTrackStyle!)
        : 'null';
    final thumb = style.thumbStyle != null
        ? _serializeSurfaceStyle(style.thumbStyle!)
        : 'null';

    return 'ToggleStyle('
        'activeType: ToggleContentType.${style.activeType.name},'
        'inactiveType: ToggleContentType.${style.inactiveType.name},'
        'activeTrackStyle: $activeTrack,'
        'inactiveTrackStyle: $inactiveTrack,'
        'thumbStyle: $thumb'
        ')';
  }

  static String _serializeNavigationStyle(NavigationStyle style) {
    return 'NavigationStyle('
        'height: ${style.height},'
        'isFloating: ${style.isFloating},'
        'floatingMargin: ${style.floatingMargin},'
        'itemSpacing: ${style.itemSpacing}'
        ')';
  }

  static String _serializeLoaderStyle(LoaderStyle style) {
    return 'LoaderStyle('
        'type: LoaderType.${style.type.name},'
        'color: ${_colorToString(style.color ?? const Color(0xFF000000))},'
        'backgroundColor: ${style.backgroundColor != null ? _colorToString(style.backgroundColor!) : 'null'},'
        'strokeWidth: ${style.strokeWidth},'
        'size: ${style.size},'
        'period: Duration(milliseconds: ${style.period.inMilliseconds})'
        ')';
  }
}
