import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'color_utils.dart';

/// Generates Dart code for the given theme.
String generateDartCode(AppDesignTheme theme) {
  final buffer = StringBuffer();

  buffer.writeln('AppDesignTheme(');
  
  // Global Metrics
  buffer.writeln('  spacingFactor: ${theme.spacingFactor},');
  buffer.writeln('  buttonHeight: ${theme.buttonHeight},');
  buffer.writeln(_generateAnimationSpec(theme.animation));
  
  // Specs
  buffer.writeln(_generateSurfaceStyle('surfaceBase', theme.surfaceBase));
  buffer.writeln(_generateSurfaceStyle('surfaceElevated', theme.surfaceElevated));
  buffer.writeln(_generateSurfaceStyle('surfaceHighlight', theme.surfaceHighlight));
  buffer.writeln(_generateInputStyle(theme.inputStyle));
  buffer.writeln(_generateToggleStyle(theme.toggleStyle));
  buffer.writeln(_generateLoaderStyle(theme.loaderStyle));
  buffer.writeln(_generateNavigationStyle(theme.navigationStyle));
  
  // Fill required fields with current values (simplification for now)
  buffer.writeln(_generateSkeletonStyle(theme.skeletonStyle));
  buffer.writeln(_generateToastStyle(theme.toastStyle));
  buffer.writeln(_generateDividerStyle(theme.dividerStyle));
  buffer.writeln(_generateNetworkInputStyle(theme.networkInputStyle));
  buffer.writeln(_generateTypographySpec(theme.typography));
  buffer.writeln(_generateLayoutSpec(theme.layoutSpec));

  buffer.writeln(')');

  return buffer.toString();
}

String _color(Color? color) {
  if (color == null) return 'Colors.transparent';
  return 'Color(0x${color.value.toRadixString(16).toUpperCase().padLeft(8, '0')})';
}

String _generateAnimationSpec(AnimationSpec spec) {
  return '  animation: AnimationSpec(\n' 
         '    duration: Duration(milliseconds: ${spec.duration.inMilliseconds}),\n' 
         '    curve: Curves.easeInOut,\n' 
         '  ),';
}

String _generateSurfaceStyle(String paramName, SurfaceStyle style) {
  final buffer = StringBuffer();
  buffer.writeln('  $paramName: SurfaceStyle(');
  buffer.writeln('    backgroundColor: ${_color(style.backgroundColor)},');
  buffer.writeln('    borderColor: ${_color(style.borderColor)},');
  buffer.writeln('    borderWidth: ${style.borderWidth},');
  buffer.writeln('    borderRadius: ${style.borderRadius},');
  buffer.writeln('    blurStrength: ${style.blurStrength},');
  buffer.writeln('    contentColor: ${_color(style.contentColor)},');
  if (style.shadows != null && style.shadows!.isNotEmpty) {
    final shadow = style.shadows!.first;
    buffer.writeln('    shadows: [\n' 
                   '      BoxShadow(\n' 
                   '        color: ${_color(shadow.color)},\n' 
                   '        blurRadius: ${shadow.blurRadius},\n' 
                   '        offset: Offset(${shadow.offset.dx}, ${shadow.offset.dy}),\n' 
                   '      )\n' 
                   '    ],');
  } else {
    buffer.writeln('    shadows: const [],');
  }
  buffer.writeln('  ),');
  return buffer.toString();
}

String _generateInputStyle(InputStyle style) {
  final buffer = StringBuffer();
  buffer.writeln('  inputStyle: InputStyle(');
  buffer.writeln('    outlineStyle: ${_generateNestedSurfaceStyle(style.outlineStyle)},');
  buffer.writeln('    underlineStyle: ${_generateNestedSurfaceStyle(style.underlineStyle)},');
  buffer.writeln('    filledStyle: ${_generateNestedSurfaceStyle(style.filledStyle)},');
  buffer.writeln('    focusModifier: ${_generateNestedSurfaceStyle(style.focusModifier)},');
  buffer.writeln('    errorModifier: ${_generateNestedSurfaceStyle(style.errorModifier)},');
  buffer.writeln('  ),');
  return buffer.toString();
}

String _generateNestedSurfaceStyle(SurfaceStyle? style) {
  if (style == null) return 'null';
  final buffer = StringBuffer();
  buffer.writeln('SurfaceStyle(');
  buffer.writeln('      backgroundColor: ${_color(style.backgroundColor)},');
  buffer.writeln('      borderColor: ${_color(style.borderColor)},');
  buffer.writeln('      borderWidth: ${style.borderWidth},');
  buffer.writeln('      borderRadius: ${style.borderRadius},');
  buffer.writeln('      blurStrength: ${style.blurStrength},');
  buffer.writeln('      contentColor: ${_color(style.contentColor)},');
  buffer.writeln('      shadows: const [],');
  buffer.write('    )');
  return buffer.toString();
}

String _generateToggleStyle(ToggleStyle style) {
  return '  toggleStyle: ToggleStyle(\n' 
         '    activeType: ${style.activeType},\n' 
         '    inactiveType: ${style.inactiveType},\n' 
         '    activeTrackStyle: ${_generateNestedSurfaceStyle(style.activeTrackStyle)},\n' 
         '    inactiveTrackStyle: ${_generateNestedSurfaceStyle(style.inactiveTrackStyle)},\n' 
         '    thumbStyle: ${_generateNestedSurfaceStyle(style.thumbStyle)},\n' 
         '  ),';
}

String _generateLoaderStyle(LoaderStyle style) {
  return '  loaderStyle: LoaderStyle(\n' 
         '    type: ${style.type},\n' 
         '    color: ${_color(style.color)},\n' 
         '    strokeWidth: ${style.strokeWidth},\n' 
         '    size: ${style.size},\n' 
         '    period: Duration(milliseconds: ${style.period.inMilliseconds}),\n' 
         '  ),';
}

String _generateNavigationStyle(NavigationStyle style) {
  return '  navigationStyle: NavigationStyle(\n' 
         '    height: ${style.height},\n' 
         '    isFloating: ${style.isFloating},\n' 
         '    floatingMargin: ${style.floatingMargin},\n' 
         '    itemSpacing: ${style.itemSpacing},\n' 
         '  ),';
}

String _generateSkeletonStyle(SkeletonStyle style) {
  return '  skeletonStyle: SkeletonStyle(\n' 
         '    baseColor: ${_color(style.baseColor)},\n' 
         '    highlightColor: ${_color(style.highlightColor)},\n' 
         '    animationType: ${style.animationType},\n' 
         '    borderRadius: ${style.borderRadius},\n' 
         '  ),';
}

String _generateToastStyle(ToastStyle style) {
  return '  toastStyle: ToastStyle(\n' 
         '    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),\n' 
         '    margin: const EdgeInsets.all(16),\n' 
         '    borderRadius: BorderRadius.circular(${style.borderRadius is BorderRadius ? (style.borderRadius as BorderRadius).topLeft.x : 8.0}),\n' 
         '    backgroundColor: ${_color(style.backgroundColor)},\n' 
         '    textStyle: TextStyle(fontSize: 14, color: ${_color(Colors.white)}),\n' 
         '    displayDuration: Duration(seconds: ${style.displayDuration.inSeconds}),\n' 
         '  ),';
}

String _generateDividerStyle(DividerStyle style) {
  return '  dividerStyle: DividerStyle(\n' 
         '    color: ${_color(style.color)},\n' 
         '    thickness: ${style.thickness},\n' 
         '    pattern: ${style.pattern},\n' 
         '    indent: ${style.indent},\n' 
         '    endIndent: ${style.endIndent},\n' 
         '  ),';
}

String _generateNetworkInputStyle(NetworkInputStyle style) {
  return "  networkInputStyle: NetworkInputStyle(\n"
         "    ipv4SeparatorStyle: ${style.ipv4SeparatorStyle},\n"
         "    macAddressSeparator: '${style.macAddressSeparator}',\n"
         "  ),";
}

String _generateTypographySpec(TypographySpec spec) {
  return "  typography: TypographySpec(\n"
         "    bodyFontFamily: '${spec.bodyFontFamily}',\n"
         "    displayFontFamily: '${spec.displayFontFamily}',\n"
         "  ),";
}

String _generateLayoutSpec(LayoutSpec spec) {
  return '  layoutSpec: LayoutSpec(\n' 
         '    breakpointMobile: ${spec.breakpointMobile},\n' 
         '    breakpointTablet: ${spec.breakpointTablet},\n' 
         '    breakpointDesktop: ${spec.breakpointDesktop},\n' 
         '    gutterMobile: ${spec.gutterMobile},\n' 
         '    gutterTablet: ${spec.gutterTablet},\n' 
         '    gutterDesktop: ${spec.gutterDesktop},\n' 
         '    marginMobile: ${spec.marginMobile},\n' 
         '    marginTablet: ${spec.marginTablet},\n' 
         '    marginDesktop: ${spec.marginDesktop},\n' 
         '    maxColumns: ${spec.maxColumns},\n' 
         '  ),';
}