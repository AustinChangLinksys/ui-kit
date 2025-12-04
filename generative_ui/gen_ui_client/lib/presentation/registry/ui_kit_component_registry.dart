import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:generative_ui/generative_ui.dart';
import 'package:ui_kit_library/ui_kit.dart';

import 'component_builder.dart';

/// Registry of all UI Kit components for AI-generated layouts.
///
/// Provides:
/// - Component registration for the generative_ui ComponentRegistry
/// - Tool definitions for LLM tool use
/// - Error fallback for unknown components
///
/// Contains 31 UI Kit components (9 atoms + 22 molecules) plus
/// 9 Flutter layout containers.
class UiKitComponentRegistry {
  UiKitComponentRegistry._();

  /// Enable debug logging for component building.
  /// Set to true for development debugging.
  static bool enableDebugLogs = false;

  /// Enable debug borders around each component for visualization.
  /// Set to true to see component boundaries during development.
  static bool enableDebugBorders = false;

  /// Color palette for debug borders (cycles through for nested components)
  static const List<Color> _debugColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
  ];

  static int _colorIndex = 0;

  static void _log(String message) {
    if (enableDebugLogs) {
      debugPrint('[UiKitRegistry] $message');
    }
  }

  /// Wraps a widget with debug border if enabled
  static Widget _wrapWithDebugBorder(Widget child, String componentName) {
    if (!enableDebugBorders) return child;

    final color = _debugColors[_colorIndex % _debugColors.length];
    _colorIndex++;

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: child,
          ),
          Positioned(
            top: 0,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                componentName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Registers all UI Kit components with the given registry.
  static void registerAll(ComponentRegistry registry) {
    _builders.forEach((name, builder) {
      registry.register(name, (context, props, {onAction}) {
        _log('Building component: $name');
        _log('Props type: ${props.runtimeType}');
        _log('Props: $props');

        try {
          // Build children recursively if present
          final children = _buildChildren(context, props, onAction);
          final widget = builder(context, props, onAction: onAction, children: children);
          return _wrapWithDebugBorder(widget, name);
        } catch (e, stackTrace) {
          _log('Error building $name: $e');
          _log('Stack trace: $stackTrace');
          return buildErrorFallback('$name: $e', context);
        }
      });
    });
  }

  /// Recursively builds children from props.
  static List<Widget>? _buildChildren(
    BuildContext context,
    Map<String, dynamic> props,
    void Function(Map<String, dynamic>)? onAction,
  ) {
    final rawChildren = props['children'];
    _log('Raw children type: ${rawChildren.runtimeType}');
    _log('Raw children: $rawChildren');

    if (rawChildren == null) return null;

    List<dynamic> childrenData;

    // Handle different children formats
    if (rawChildren is List<dynamic>) {
      childrenData = rawChildren;
    } else if (rawChildren is String) {
      // Try to parse JSON string
      try {
        final parsed = jsonDecode(rawChildren);
        if (parsed is List<dynamic>) {
          childrenData = parsed;
        } else {
          _log('Parsed children is not a List: ${parsed.runtimeType}');
          return null;
        }
      } catch (e) {
        _log('Failed to parse children JSON string: $e');
        return null;
      }
    } else {
      _log('Unknown children type: ${rawChildren.runtimeType}');
      return null;
    }

    _log('Building ${childrenData.length} children');

    return childrenData.map((child) {
      return _buildChildWidget(context, child, onAction);
    }).toList();
  }

  /// Builds a single child widget from its data.
  static Widget _buildChildWidget(
    BuildContext context,
    dynamic child,
    void Function(Map<String, dynamic>)? onAction,
  ) {
    _log('Building child: ${child.runtimeType}');

    if (child is! Map<String, dynamic>) {
      // Try to parse if it's a string
      if (child is String) {
        try {
          final parsed = jsonDecode(child);
          if (parsed is Map<String, dynamic>) {
            return _buildChildWidget(context, parsed, onAction);
          }
        } catch (e) {
          _log('Failed to parse child string: $e');
        }
      }
      _log('Child is not a Map: ${child.runtimeType}');
      return const SizedBox.shrink();
    }

    final childType = child['type'] as String?;
    _log('Child type: $childType');

    if (childType == null) {
      _log('Child has no type field');
      return const SizedBox.shrink();
    }

    final childBuilder = _builders[childType];
    if (childBuilder == null) {
      _log('No builder found for type: $childType');
      return buildErrorFallback('Unknown: $childType', context);
    }

    // Get props - either from 'props' field or use the whole child object
    final childProps = child['props'] as Map<String, dynamic>? ?? child;
    _log('Child props: $childProps');

    // Recursively build grandchildren
    final grandchildren = _buildChildren(context, childProps, onAction);

    return childBuilder(
      context,
      childProps,
      onAction: onAction,
      children: grandchildren,
    );
  }

  /// Creates tool definitions for all registered components.
  static List<GenTool> createToolDefinitions() {
    return [
      // Layout containers - most commonly used
      GenTool(
        name: 'Column',
        description:
            'Vertical layout container. Use for stacking widgets vertically. '
            'Use AppGap for spacing between children.',
        inputSchema: _columnSchema(),
      ),
      GenTool(
        name: 'Row',
        description:
            'Horizontal layout container. Use for placing widgets side by side. '
            'Use expandChildren: true to make children fill equal width.',
        inputSchema: _rowSchema(),
      ),
      GenTool(
        name: 'AppCard',
        description:
            'Card container. Use for grouping related content with elevation.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'children': {'type': 'array', 'description': 'Child components'},
          },
        },
      ),
      // Basic components
      GenTool(
        name: 'AppButton',
        description: 'Action button. Use for user interactions.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'label': {'type': 'string', 'description': 'Button text'},
            'variant': {
              'type': 'string',
              'enum': ['base', 'elevated', 'highlight'],
              'description': 'Visual variant'
            },
            'isLoading': {
              'type': 'boolean',
              'description': 'Show loading state'
            },
          },
          'required': ['label'],
        },
      ),
      GenTool(
        name: 'AppTextField',
        description: 'Text input field. Use for user text entry.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'hintText': {
              'type': 'string',
              'description': 'Placeholder hint text'
            },
            'obscureText': {
              'type': 'boolean',
              'description': 'Hide text (for passwords)'
            },
          },
        },
      ),
      GenTool(
        name: 'AppText',
        description: 'Text display component with typography variants.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'text': {
              'type': 'string',
              'description': 'Text content to display'
            },
            'variant': {
              'type': 'string',
              'enum': [
                'displayLarge',
                'displayMedium',
                'headlineMedium',
                'titleMedium',
                'bodyMedium',
                'bodySmall',
                'labelMedium'
              ],
              'description': 'Typography variant',
            },
          },
          'required': ['text'],
        },
      ),
      GenTool(
        name: 'AppGap',
        description: 'Spacing component. Use to add space between elements.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'size': {
              'type': 'string',
              'enum': ['xs', 'sm', 'md', 'lg', 'xl'],
              'description': 'Gap size'
            },
          },
        },
      ),
      GenTool(
        name: 'AppDivider',
        description: 'Visual separator line.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'axis': {
              'type': 'string',
              'enum': ['horizontal', 'vertical'],
              'description': 'Divider orientation'
            },
          },
        },
      ),
      GenTool(
        name: 'AppListTile',
        description:
            'List item with leading icon, title, subtitle, and trailing widget.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'title': {'type': 'string', 'description': 'Primary text'},
            'subtitle': {'type': 'string', 'description': 'Secondary text'},
          },
          'required': ['title'],
        },
      ),
      GenTool(
        name: 'AppTag',
        description: 'Label tag for categorization.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'label': {'type': 'string', 'description': 'Tag text'},
          },
          'required': ['label'],
        },
      ),
      GenTool(
        name: 'AppSwitch',
        description: 'Toggle switch for boolean settings.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'value': {'type': 'boolean', 'description': 'Current state'},
          },
        },
      ),
      GenTool(
        name: 'AppCheckbox',
        description: 'Checkbox for boolean selection.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'value': {'type': 'boolean', 'description': 'Current state'},
            'label': {'type': 'string', 'description': 'Checkbox label'},
          },
        },
      ),
    ];
  }

  /// Schema for Column - no expandChildren (unbounded height context)
  static Map<String, dynamic> _columnSchema() {
    return {
      'type': 'object',
      'properties': {
        'mainAxisAlignment': {
          'type': 'string',
          'enum': [
            'start',
            'end',
            'center',
            'spaceBetween',
            'spaceAround',
            'spaceEvenly'
          ],
          'description': 'Vertical alignment of children',
        },
        'crossAxisAlignment': {
          'type': 'string',
          'enum': ['start', 'end', 'center', 'stretch'],
          'description': 'Horizontal alignment of children',
        },
        'children': {
          'type': 'array',
          'items': {'type': 'object'},
          'description': 'Child components. Use AppGap between children for spacing.',
        },
      },
    };
  }

  /// Schema for Row - supports expandChildren for equal width distribution
  static Map<String, dynamic> _rowSchema() {
    return {
      'type': 'object',
      'properties': {
        'mainAxisAlignment': {
          'type': 'string',
          'enum': [
            'start',
            'end',
            'center',
            'spaceBetween',
            'spaceAround',
            'spaceEvenly'
          ],
          'description': 'Horizontal alignment of children',
        },
        'crossAxisAlignment': {
          'type': 'string',
          'enum': ['start', 'end', 'center', 'stretch'],
          'description': 'Vertical alignment of children',
        },
        'expandChildren': {
          'type': 'boolean',
          'description':
              'If true, all children will expand equally to fill available width. '
                  'Use this when you want children to have equal width.',
        },
        'children': {
          'type': 'array',
          'items': {'type': 'object'},
          'description': 'Child components. Use AppGap between children for spacing.',
        },
      },
    };
  }

  /// Map of component builders.
  static final Map<String, ComponentBuilder> _builders = {
    // ==================== ATOMS ====================

    // AppSurface
    'AppSurface': (context, props, {onAction, children}) {
      return AppSurface(
        variant: _parseSurfaceVariant(props['variant'] as String?),
        child: children?.isNotEmpty == true
            ? (children!.length == 1
                ? children.first
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ))
            : const SizedBox.shrink(),
      );
    },

    // AppText
    'AppText': (context, props, {onAction, children}) {
      final text = props['text'] as String? ?? '';
      final variant = props['variant'] as String?;
      final textAlign = _parseTextAlign(props['textAlign'] as String?);

      return AppText(
        text,
        variant: _parseTextVariant(variant),
        textAlign: textAlign,
      );
    },

    // AppIcon
    'AppIcon': (context, props, {onAction, children}) {
      final iconName =
          props['icon'] as String? ?? props['name'] as String? ?? 'help';
      return Icon(_parseIconData(iconName));
    },

    // AppGap
    'AppGap': (context, props, {onAction, children}) {
      final size = props['size'] as String? ?? 'md';
      return _buildGap(size);
    },

    // AppDivider
    // Wrapped in LayoutBuilder to handle unbounded constraints
    // (horizontal dividers need width, vertical need height)
    'AppDivider': (context, props, {onAction, children}) {
      final axisStr = props['axis'] as String?;
      final axis = axisStr == 'vertical' ? Axis.vertical : Axis.horizontal;

      return LayoutBuilder(
        builder: (context, constraints) {
          // For horizontal dividers, provide bounded width if unbounded
          if (axis == Axis.horizontal && !constraints.maxWidth.isFinite) {
            return AppDivider(axis: axis, width: 200);
          }
          // For vertical dividers, provide bounded height if unbounded
          if (axis == Axis.vertical && !constraints.maxHeight.isFinite) {
            return AppDivider(axis: axis, height: 50);
          }
          return AppDivider(axis: axis);
        },
      );
    },

    // AppSkeleton
    'AppSkeleton': (context, props, {onAction, children}) {
      final width = (props['width'] as num?)?.toDouble();
      final height = (props['height'] as num?)?.toDouble() ?? 16.0;
      return AppSkeleton(width: width, height: height);
    },

    // ThemeAwareImage - simplified placeholder
    'ThemeAwareImage': (context, props, {onAction, children}) {
      return const AppSurface(
        variant: SurfaceVariant.base,
        child: SizedBox(
            width: 100, height: 100, child: Icon(Icons.image)),
      );
    },

    // ThemeAwareSvg - simplified placeholder
    'ThemeAwareSvg': (context, props, {onAction, children}) {
      return const SizedBox(width: 24, height: 24, child: Icon(Icons.image));
    },

    // ProductImage - simplified placeholder
    'ProductImage': (context, props, {onAction, children}) {
      return const AppSurface(
        variant: SurfaceVariant.base,
        child: SizedBox(
            width: 100, height: 100, child: Icon(Icons.inventory_2)),
      );
    },

    // ==================== MOLECULES - BUTTONS ====================

    // AppButton
    'AppButton': (context, props, {onAction, children}) {
      final label = props['label'] as String? ?? 'Button';
      final variant = _parseSurfaceVariant(props['variant'] as String?);
      final isLoading = props['isLoading'] as bool? ?? false;
      final iconName = props['icon'] as String?;

      return AppButton(
        label: label,
        variant: variant,
        isLoading: isLoading,
        onTap: () => onAction?.call({'action': 'pressed', 'button': label}),
        icon: iconName != null ? Icon(_parseIconData(iconName)) : null,
      );
    },

    // AppIconButton
    'AppIconButton': (context, props, {onAction, children}) {
      final iconName = props['icon'] as String? ?? 'add';
      final variant = _parseSurfaceVariant(props['variant'] as String?);

      return AppIconButton(
        icon: Icon(_parseIconData(iconName)),
        variant: variant,
        onTap: () => onAction?.call({'action': 'pressed', 'icon': iconName}),
      );
    },

    // ==================== MOLECULES - INPUTS ====================

    // AppTextField
    'AppTextField': (context, props, {onAction, children}) {
      final hint = props['hintText'] as String? ?? props['hint'] as String?;
      final obscureText = props['obscureText'] as bool? ?? false;

      return AppTextField(
        hintText: hint,
        obscureText: obscureText,
        onChanged: (value) =>
            onAction?.call({'action': 'changed', 'value': value}),
      );
    },

    // AppTextFormField
    'AppTextFormField': (context, props, {onAction, children}) {
      final hint = props['hintText'] as String? ?? props['hint'] as String?;

      return AppTextFormField(
        hintText: hint,
        onChanged: (value) =>
            onAction?.call({'action': 'changed', 'value': value}),
      );
    },

    // AppDropdown
    'AppDropdown': (context, props, {onAction, children}) {
      final items = (props['items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['Option 1', 'Option 2'];
      final value = props['value'] as String?;

      return AppDropdown<String>(
        items: items,
        value: value ?? (items.isNotEmpty ? items.first : null),
        onChanged: (val) =>
            onAction?.call({'action': 'selected', 'value': val}),
      );
    },

    // ==================== MOLECULES - NETWORK INPUTS ====================

    // AppIpv4TextField
    'AppIpv4TextField': (context, props, {onAction, children}) {
      return AppIpv4TextField(
        label: props['label'] as String? ?? 'IPv4 Address',
      );
    },

    // AppIPv6TextField
    'AppIPv6TextField': (context, props, {onAction, children}) {
      return AppIPv6TextField(
        label: props['label'] as String? ?? 'IPv6 Address',
        hintText: props['hintText'] as String? ?? '::',
        invalidFormatMessage: 'Invalid IPv6 format',
        onChanged: (value) =>
            onAction?.call({'action': 'changed', 'value': value}),
      );
    },

    // AppMacAddressTextField
    'AppMacAddressTextField': (context, props, {onAction, children}) {
      return AppMacAddressTextField(
        label: props['label'] as String? ?? 'MAC Address',
        invalidFormatMessage: 'Invalid MAC address format',
        onChanged: (value) =>
            onAction?.call({'action': 'changed', 'value': value}),
      );
    },

    // ==================== MOLECULES - SELECTION ====================

    // AppCheckbox
    'AppCheckbox': (context, props, {onAction, children}) {
      final value = props['value'] as bool? ?? false;
      final label = props['label'] as String?;

      return AppCheckbox(
        value: value,
        label: label,
        onChanged: (val) =>
            onAction?.call({'action': 'toggled', 'value': val}),
      );
    },

    // AppRadio
    'AppRadio': (context, props, {onAction, children}) {
      final value = props['value'];
      final groupValue = props['groupValue'];
      final label = props['label'] as String?;

      return AppRadio<dynamic>(
        value: value,
        groupValue: groupValue,
        label: label,
        onChanged: (val) =>
            onAction?.call({'action': 'selected', 'value': val}),
      );
    },

    // AppSlider
    'AppSlider': (context, props, {onAction, children}) {
      final value = (props['value'] as num?)?.toDouble() ?? 0.5;
      final min = (props['min'] as num?)?.toDouble() ?? 0.0;
      final max = (props['max'] as num?)?.toDouble() ?? 1.0;

      return AppSlider(
        value: value,
        min: min,
        max: max,
        onChanged: (val) =>
            onAction?.call({'action': 'changed', 'value': val}),
      );
    },

    // ==================== MOLECULES - TOGGLES ====================

    // AppSwitch
    'AppSwitch': (context, props, {onAction, children}) {
      final value = props['value'] as bool? ?? false;

      return AppSwitch(
        value: value,
        onChanged: (val) =>
            onAction?.call({'action': 'toggled', 'value': val}),
      );
    },

    // ==================== MOLECULES - STATUS ====================

    // AppBadge
    'AppBadge': (context, props, {onAction, children}) {
      final label = props['label'] as String? ?? '0';
      return AppBadge(label: label);
    },

    // AppTag
    'AppTag': (context, props, {onAction, children}) {
      final label = props['label'] as String? ?? 'Tag';
      return AppTag(label: label);
    },

    // AppAvatar
    'AppAvatar': (context, props, {onAction, children}) {
      final initials = props['initials'] as String? ?? 'A';
      final imageUrl = props['imageUrl'] as String?;
      final size = (props['size'] as num?)?.toDouble() ?? 40.0;

      return AppAvatar(
        initials: initials,
        imageUrl: imageUrl,
        size: size,
      );
    },

    // ==================== MOLECULES - FEEDBACK ====================

    // AppLoader
    'AppLoader': (context, props, {onAction, children}) {
      return const AppLoader();
    },

    // AppToast - rendered inline as surface
    'AppToast': (context, props, {onAction, children}) {
      final message = props['message'] as String? ?? 'Toast message';
      return AppSurface(
        variant: SurfaceVariant.elevated,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: AppText(message),
        ),
      );
    },

    // ==================== MOLECULES - DISPLAY ====================

    // AppTooltip
    'AppTooltip': (context, props, {onAction, children}) {
      final message = props['message'] as String? ?? 'Tooltip';
      return AppTooltip(
        message: message,
        child: children?.firstOrNull ?? const Icon(Icons.info),
      );
    },

    // ==================== MOLECULES - LAYOUT ====================

    // AppListTile
    // Wrapped in IntrinsicWidth to handle unbounded width constraints
    // (e.g., when placed inside a Row without Expanded)
    'AppListTile': (context, props, {onAction, children}) {
      final title = props['title'] as String? ?? '';
      final subtitle = props['subtitle'] as String?;
      final leadingIcon = props['leading'] as String?;
      final trailing = props['trailing'] as String?;

      Widget? trailingWidget;
      if (trailing == 'switch') {
        trailingWidget = AppSwitch(
          value: props['trailingValue'] as bool? ?? false,
          onChanged: (val) =>
              onAction?.call({'action': 'toggled', 'value': val}),
        );
      } else if (trailing == 'chevron_right') {
        trailingWidget = const Icon(Icons.chevron_right);
      } else if (trailing != null) {
        trailingWidget = Icon(_parseIconData(trailing));
      }

      // Wrap in IntrinsicWidth to provide bounded width when parent has
      // unbounded constraints (fixes "non-zero flex but incoming width
      // constraints are unbounded" error)
      return IntrinsicWidth(
        child: AppListTile(
          title: AppText(title),
          subtitle: subtitle != null
              ? AppText(subtitle, variant: AppTextVariant.bodySmall)
              : null,
          leading:
              leadingIcon != null ? Icon(_parseIconData(leadingIcon)) : null,
          trailing: trailingWidget,
          onTap: () => onAction?.call({'action': 'tapped', 'title': title}),
        ),
      );
    },

    // AppCard
    'AppCard': (context, props, {onAction, children}) {
      return AppCard(
        child: children?.isNotEmpty == true
            ? (children!.length == 1
                ? children.first
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ))
            : const SizedBox.shrink(),
      );
    },

    // ==================== MOLECULES - NAVIGATION ====================

    // AppNavigationBar
    'AppNavigationBar': (context, props, {onAction, children}) {
      final currentIndex = props['currentIndex'] as int? ?? 0;
      final itemsData = props['items'] as List<dynamic>? ?? [];

      final items = itemsData.map((item) {
        if (item is Map<String, dynamic>) {
          return AppNavigationItem(
            icon: Icon(_parseIconData(item['icon'] as String? ?? 'home')),
            label: item['label'] as String? ?? 'Item',
          );
        }
        return const AppNavigationItem(
          icon: Icon(Icons.home),
          label: 'Home',
        );
      }).toList();

      if (items.isEmpty) {
        items.addAll(const [
          AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
          AppNavigationItem(icon: Icon(Icons.search), label: 'Search'),
          AppNavigationItem(icon: Icon(Icons.person), label: 'Profile'),
        ]);
      }

      return AppNavigationBar(
        currentIndex: currentIndex,
        items: items,
        onTap: (index) =>
            onAction?.call({'action': 'selected', 'index': index}),
      );
    },

    // AppNavigationRail
    'AppNavigationRail': (context, props, {onAction, children}) {
      final currentIndex = props['currentIndex'] as int? ?? 0;
      final itemsData = props['items'] as List<dynamic>? ?? [];

      final items = itemsData.map((item) {
        if (item is Map<String, dynamic>) {
          return AppNavigationItem(
            icon: Icon(_parseIconData(item['icon'] as String? ?? 'home')),
            label: item['label'] as String? ?? 'Item',
          );
        }
        return const AppNavigationItem(
          icon: Icon(Icons.home),
          label: 'Home',
        );
      }).toList();

      if (items.isEmpty) {
        items.addAll(const [
          AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
          AppNavigationItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]);
      }

      return AppNavigationRail(
        currentIndex: currentIndex,
        items: items,
        onTap: (index) =>
            onAction?.call({'action': 'selected', 'index': index}),
      );
    },

    // AppNavigationItem - usually used within NavigationBar/Rail
    'AppNavigationItem': (context, props, {onAction, children}) {
      final icon = props['icon'] as String? ?? 'home';
      final label = props['label'] as String? ?? 'Item';
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_parseIconData(icon)),
          const SizedBox(width: 8),
          AppText(label),
        ],
      );
    },

    // ==================== MOLECULES - DIALOGS ====================

    // AppDialog - rendered inline as surface
    'AppDialog': (context, props, {onAction, children}) {
      final title = props['title'] as String?;
      final message = props['message'] as String?;

      return AppSurface(
        variant: SurfaceVariant.elevated,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                AppText(title, variant: AppTextVariant.titleLarge),
                const SizedBox(height: 16),
              ],
              if (message != null) ...[
                AppText(message),
                const SizedBox(height: 24),
              ],
              if (children != null) ...children,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Cancel',
                    variant: SurfaceVariant.base,
                    onTap: () => onAction?.call({'action': 'cancel'}),
                  ),
                  const SizedBox(width: 12),
                  AppButton(
                    label: 'Confirm',
                    variant: SurfaceVariant.highlight,
                    onTap: () => onAction?.call({'action': 'confirm'}),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },

    // ==================== MOLECULES - MENU ====================

    // AppPopupMenu
    'AppPopupMenu': (context, props, {onAction, children}) {
      final items = (props['items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['Option 1', 'Option 2'];

      return AppPopupMenu<String>(
        items: items
            .map((item) => AppPopupMenuItem(value: item, label: item))
            .toList(),
        onSelected: (val) =>
            onAction?.call({'action': 'selected', 'value': val}),
        child: children?.firstOrNull ?? const Icon(Icons.more_vert),
      );
    },

    // AppPopupMenuItem - usually used within AppPopupMenu
    'AppPopupMenuItem': (context, props, {onAction, children}) {
      final label = props['label'] as String? ?? 'Menu Item';
      return AppListTile(
        title: AppText(label),
        onTap: () => onAction?.call({'action': 'tapped', 'label': label}),
      );
    },

    // ==================== FLUTTER LAYOUT CONTAINERS ====================

    // Column
    // Supports: mainAxisAlignment, crossAxisAlignment
    // Note: expandChildren is NOT supported for Column because it's typically
    // used in unbounded height contexts (ListView, ScrollView) where Expanded fails.
    // Use AppGap for spacing between children.
    'Column': (context, props, {onAction, children}) {
      return Column(
        mainAxisAlignment:
            _parseMainAxisAlignment(props['mainAxisAlignment'] as String?),
        crossAxisAlignment:
            _parseCrossAxisAlignment(props['crossAxisAlignment'] as String?),
        mainAxisSize: MainAxisSize.min,
        children: children ?? [],
      );
    },

    // Row
    // Supports: mainAxisAlignment, crossAxisAlignment, expandChildren
    // Use AppGap for spacing between children
    'Row': (context, props, {onAction, children}) {
      final crossAlignment =
          _parseCrossAxisAlignment(props['crossAxisAlignment'] as String?);
      final expandChildren = props['expandChildren'] as bool? ?? false;
      List<Widget> processedChildren = children ?? [];

      // Wrap children in Expanded if expandChildren is true
      if (expandChildren) {
        processedChildren = processedChildren
            .map((child) => Expanded(child: child))
            .toList();
      }

      final row = Row(
        mainAxisAlignment:
            _parseMainAxisAlignment(props['mainAxisAlignment'] as String?),
        crossAxisAlignment: crossAlignment,
        mainAxisSize: expandChildren ? MainAxisSize.max : MainAxisSize.min,
        children: processedChildren,
      );

      // Wrap in IntrinsicHeight when stretch is used to provide bounded height
      if (crossAlignment == CrossAxisAlignment.stretch) {
        return IntrinsicHeight(child: row);
      }
      return row;
    },

    // Wrap
    'Wrap': (context, props, {onAction, children}) {
      final spacing = (props['spacing'] as num?)?.toDouble() ?? 8.0;
      final runSpacing = (props['runSpacing'] as num?)?.toDouble() ?? 8.0;
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: children ?? [],
      );
    },

    // Stack
    'Stack': (context, props, {onAction, children}) {
      return Stack(
        children: children ?? [],
      );
    },

    // Center
    'Center': (context, props, {onAction, children}) {
      return Center(
        child: children?.firstOrNull,
      );
    },

    // Padding
    'Padding': (context, props, {onAction, children}) {
      final all = (props['padding'] as num?)?.toDouble() ?? 16.0;
      return Padding(
        padding: EdgeInsets.all(all),
        child: children?.isNotEmpty == true
            ? (children!.length == 1
                ? children.first
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ))
            : null,
      );
    },

    // SizedBox
    'SizedBox': (context, props, {onAction, children}) {
      final width = (props['width'] as num?)?.toDouble();
      final height = (props['height'] as num?)?.toDouble();
      return SizedBox(
        width: width,
        height: height,
        child: children?.firstOrNull,
      );
    },

    // Expanded
    'Expanded': (context, props, {onAction, children}) {
      final flex = props['flex'] as int? ?? 1;
      return Expanded(
        flex: flex,
        child: children?.firstOrNull ?? const SizedBox.shrink(),
      );
    },

    // Flexible
    'Flexible': (context, props, {onAction, children}) {
      final flex = props['flex'] as int? ?? 1;
      return Flexible(
        flex: flex,
        child: children?.firstOrNull ?? const SizedBox.shrink(),
      );
    },
  };

  /// Builds error fallback using AppSurface (Constitution 5.1 compliant).
  static Widget buildErrorFallback(String componentName, BuildContext context) {
    return AppSurface(
      variant: SurfaceVariant.base,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                color: Theme.of(context).colorScheme.error),
            const SizedBox(width: 8),
            AppText(
              'Unknown component: $componentName',
              variant: AppTextVariant.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HELPER FUNCTIONS ====================

  static Widget _buildGap(String size) {
    switch (size) {
      case 'xs':
        return AppGap.xs();
      case 'sm':
        return AppGap.sm();
      case 'lg':
        return AppGap.lg();
      case 'xl':
        return AppGap.xl();
      case 'md':
      default:
        return AppGap.md();
    }
  }

  static SurfaceVariant _parseSurfaceVariant(String? variant) {
    switch (variant) {
      case 'elevated':
        return SurfaceVariant.elevated;
      case 'highlight':
        return SurfaceVariant.highlight;
      default:
        return SurfaceVariant.base;
    }
  }

  static AppTextVariant _parseTextVariant(String? variant) {
    switch (variant) {
      case 'displayLarge':
        return AppTextVariant.displayLarge;
      case 'displayMedium':
        return AppTextVariant.displayMedium;
      case 'displaySmall':
        return AppTextVariant.displaySmall;
      case 'headlineLarge':
        return AppTextVariant.headlineLarge;
      case 'headlineMedium':
        return AppTextVariant.headlineMedium;
      case 'headlineSmall':
        return AppTextVariant.headlineSmall;
      case 'titleLarge':
        return AppTextVariant.titleLarge;
      case 'titleMedium':
        return AppTextVariant.titleMedium;
      case 'titleSmall':
        return AppTextVariant.titleSmall;
      case 'bodyLarge':
        return AppTextVariant.bodyLarge;
      case 'bodyMedium':
        return AppTextVariant.bodyMedium;
      case 'bodySmall':
        return AppTextVariant.bodySmall;
      case 'labelLarge':
        return AppTextVariant.labelLarge;
      case 'labelMedium':
        return AppTextVariant.labelMedium;
      case 'labelSmall':
        return AppTextVariant.labelSmall;
      default:
        return AppTextVariant.bodyMedium;
    }
  }

  static TextAlign? _parseTextAlign(String? align) {
    switch (align) {
      case 'left':
        return TextAlign.left;
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return null;
    }
  }

  static MainAxisAlignment _parseMainAxisAlignment(String? alignment) {
    switch (alignment) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  static CrossAxisAlignment _parseCrossAxisAlignment(String? alignment) {
    switch (alignment) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static IconData _parseIconData(String iconName) {
    const iconMap = <String, IconData>{
      'home': Icons.home,
      'search': Icons.search,
      'settings': Icons.settings,
      'person': Icons.person,
      'email': Icons.email,
      'lock': Icons.lock,
      'visibility': Icons.visibility,
      'visibility_off': Icons.visibility_off,
      'add': Icons.add,
      'remove': Icons.remove,
      'edit': Icons.edit,
      'delete': Icons.delete,
      'check': Icons.check,
      'close': Icons.close,
      'menu': Icons.menu,
      'more_vert': Icons.more_vert,
      'more_horiz': Icons.more_horiz,
      'arrow_back': Icons.arrow_back,
      'arrow_forward': Icons.arrow_forward,
      'chevron_right': Icons.chevron_right,
      'chevron_left': Icons.chevron_left,
      'expand_more': Icons.expand_more,
      'expand_less': Icons.expand_less,
      'favorite': Icons.favorite,
      'favorite_border': Icons.favorite_border,
      'star': Icons.star,
      'star_border': Icons.star_border,
      'notifications': Icons.notifications,
      'info': Icons.info,
      'warning': Icons.warning,
      'error': Icons.error,
      'help': Icons.help,
      'shopping_cart': Icons.shopping_cart,
      'inventory_2': Icons.inventory_2,
      'image': Icons.image,
      'wifi': Icons.wifi,
      'dark_mode': Icons.dark_mode,
      'light_mode': Icons.light_mode,
      'language': Icons.language,
      'logout': Icons.logout,
      'login': Icons.login,
    };

    return iconMap[iconName] ?? Icons.help_outline;
  }
}
