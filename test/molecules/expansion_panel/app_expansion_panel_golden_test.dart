import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppExpansionPanel Golden Tests', () {
    final testCases = [
      GoldenTestCase(
        name: 'Collapsed state (all panels closed)',
        builder: _buildCollapsedState,
      ),
      GoldenTestCase(
        name: 'Expanded state (first panel open)',
        builder: _buildExpandedState,
      ),
      GoldenTestCase(
        name: 'Multiple open (first and third open)',
        builder: _buildMultipleOpenState,
      ),
      GoldenTestCase(
        name: 'Disabled panel state',
        builder: _buildDisabledState,
      ),
      GoldenTestCase(
        name: 'Long content with scrolling',
        builder: _buildLongContentState,
      ),
    ];

    goldenTest(
      'renders correctly across all themes',
      fileName: 'expansion_panel',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: [
          for (final testCase in testCases) ...[
            GoldenTestScenario(
              name: testCase.name,
              child: _buildThemeMatrix(testCase.builder),
            ),
          ],
        ],
      ),
      tags: ['golden'],
    );
  });
}

/// Build a matrix of all theme combinations
Widget _buildThemeMatrix(
  Widget Function(AppDesignTheme) scenarioBuilder,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: _getThemeConfigurations().map((config) {
        return Theme(
          data: config['theme'] as ThemeData,
          child: Container(
            width: 300,
            height: 400,
            color: config['backgroundColor'] as Color,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: scenarioBuilder(
                Theme.of(_createBuildContext(config['theme'] as ThemeData))
                    .extension<AppDesignTheme>()!,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

/// Get all theme + brightness combinations
List<Map<String, dynamic>> _getThemeConfigurations() {
  return [
    {
      'name': 'Glass Light',
      'theme': _buildThemeData(glassDesignTheme()),
      'backgroundColor': Colors.white,
    },
    {
      'name': 'Glass Dark',
      'theme': _buildThemeData(glassDesignTheme(brightness: Brightness.dark)),
      'backgroundColor': Colors.grey.shade900,
    },
    {
      'name': 'Brutal Light',
      'theme': _buildThemeData(brutalDesignTheme()),
      'backgroundColor': Colors.white,
    },
    {
      'name': 'Brutal Dark',
      'theme': _buildThemeData(brutalDesignTheme(brightness: Brightness.dark)),
      'backgroundColor': Colors.black,
    },
    {
      'name': 'Flat Light',
      'theme': _buildThemeData(flatDesignTheme()),
      'backgroundColor': Colors.white,
    },
    {
      'name': 'Flat Dark',
      'theme': _buildThemeData(flatDesignTheme(brightness: Brightness.dark)),
      'backgroundColor': Colors.grey.shade100,
    },
    {
      'name': 'Neumorphic Light',
      'theme': _buildThemeData(neumorphicDesignTheme()),
      'backgroundColor': Colors.white,
    },
    {
      'name': 'Neumorphic Dark',
      'theme': _buildThemeData(neumorphicDesignTheme(brightness: Brightness.dark)),
      'backgroundColor': Colors.grey.shade900,
    },
    {
      'name': 'Pixel Light',
      'theme': _buildThemeData(pixelDesignTheme()),
      'backgroundColor': Colors.white,
    },
    {
      'name': 'Pixel Dark',
      'theme': _buildThemeData(pixelDesignTheme(brightness: Brightness.dark)),
      'backgroundColor': Colors.black,
    },
  ];
}

ThemeData _buildThemeData(AppDesignTheme designTheme) {
  return ThemeData(
    useMaterial3: true,
    extensions: [designTheme],
  );
}

BuildContext _createBuildContext(ThemeData theme) {
  // Create a temporary context for theme access
  return _DummyContext(theme);
}

/// Collapsed state (all panels closed)
Widget _buildCollapsedState(AppDesignTheme theme) {
  return AppExpansionPanel(
    panels: [
      ExpansionPanelItem(
        headerTitle: 'Panel 1',
        content: const AppText('Content 1'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 2',
        content: const AppText('Content 2'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 3',
        content: const AppText('Content 3'),
      ),
    ],
    initialExpandedIndices: {},
  );
}

/// Expanded state (first panel open)
Widget _buildExpandedState(AppDesignTheme theme) {
  return AppExpansionPanel(
    panels: [
      ExpansionPanelItem(
        headerTitle: 'Panel 1',
        content: const AppText('This panel is expanded and shows its content.'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 2',
        content: const AppText('Content 2'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 3',
        content: const AppText('Content 3'),
      ),
    ],
    initialExpandedIndices: {0},
  );
}

/// Multiple open state (first and third panels open)
Widget _buildMultipleOpenState(AppDesignTheme theme) {
  return AppExpansionPanel(
    panels: [
      ExpansionPanelItem(
        headerTitle: 'Panel 1',
        content: const AppText('Panel 1 is open'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 2',
        content: const AppText('Content 2'),
      ),
      ExpansionPanelItem(
        headerTitle: 'Panel 3',
        content: const AppText('Panel 3 is also open'),
      ),
    ],
    initialExpandedIndices: {0, 2},
    allowMultipleOpen: true,
  );
}

/// Disabled panel state
Widget _buildDisabledState(AppDesignTheme theme) {
  return AppExpansionPanel(
    panels: [
      ExpansionPanelItem(
        headerTitle: 'Enabled Panel',
        content: const AppText('This panel is enabled'),
        enabled: true,
      ),
      ExpansionPanelItem(
        headerTitle: 'Disabled Panel',
        content: const AppText('This panel is disabled'),
        enabled: false,
      ),
      ExpansionPanelItem(
        headerTitle: 'Another Enabled',
        content: const AppText('This panel is enabled'),
        enabled: true,
      ),
    ],
  );
}

/// Long content with scrolling
Widget _buildLongContentState(AppDesignTheme theme) {
  return AppExpansionPanel(
    panels: [
      ExpansionPanelItem(
        headerTitle: 'Settings',
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              const SizedBox(height: 8),
              const AppText(
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
              ),
            ],
          ),
        ),
      ),
    ],
    initialExpandedIndices: {0},
  );
}

class GoldenTestCase {
  final String name;
  final Widget Function(AppDesignTheme) builder;

  GoldenTestCase({
    required this.name,
    required this.builder,
  });
}

/// Dummy BuildContext for getting theme data
class _DummyContext extends BuildContext {
  final ThemeData _theme;

  _DummyContext(this._theme);

  @override
  void visitAncestorElements(bool Function(Element element) visitor) {}

  @override
  void visitChildElements(ElementVisitor visitor) {}

  @override
  InheritedWidget dependOnInheritedElement(
    InheritedElement ancestor, {
    Object? aspect,
  }) {
    return ancestor.widget as InheritedWidget;
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({
    Object? aspect,
  }) {
    return null;
  }

  @override
  DiagnosticsNode describeElement(
    String name, {
    DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty,
  }) {
    return DiagnosticsNode.message(name);
  }

  @override
  List<DiagnosticsNode> describeMissingAncestor(
      {required Type expectedAncestorType}) {
    return [];
  }

  @override
  DiagnosticsNode describeOwnershipChain(String name) {
    return DiagnosticsNode.message(name);
  }

  @override
  void dispatchNotification(Notification notification) {}

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() {
    return null;
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    return null;
  }

  @override
  T? findRenderObject() {
    return null;
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    return null;
  }

  @override
  InheritedElement? getElementForInheritedWidgetOfExactType<
      T extends InheritedWidget>() {
    return null;
  }

  @override
  Widget getWidgetForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    throw UnsupportedError('getWidgetForInheritedWidgetOfExactType');
  }

  @override
  T? watch<T extends Listenable>(T listenable) {
    return null;
  }

  @override
  void showCheckoutWidget(
    WidgetBuilder builder, {
    RouteSettings? routeSettings,
  }) {
    throw UnsupportedError('showCheckoutWidget');
  }

  @override
  Future<T?> push<T extends Object?>(Route<T> route) async {
    return null;
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return null;
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) async {
    return null;
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Route<T> newRoute,
    bool Function(Route<dynamic>) predicate,
  ) async {
    return null;
  }

  @override
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) async {
    return null;
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    return null;
  }

  @override
  void pop<T extends Object?>([T? result]) {}

  @override
  bool canPop() {
    return false;
  }

  @override
  void popUntil(bool Function(Route<dynamic>) predicate) {}

  @override
  void replace<T extends Object?>({required Route<dynamic> oldRoute, required Route<T> newRoute}) {}

  @override
  void replaceRouteBelow<T extends Object?>({required Route<dynamic> anchorRoute, required Route<T> newRoute}) {}

  @override
  bool get mounted => false;

  @override
  Element? get owner => null;

  @override
  RenderObject get renderObject {
    throw UnsupportedError('renderObject');
  }

  @override
  Size get size {
    throw UnsupportedError('size');
  }

  @override
  State get state {
    throw UnsupportedError('state');
  }

  @override
  TickerProvider get vsync {
    throw UnsupportedError('vsync');
  }

  @override
  T? getState<T extends State<StatefulWidget>>() {
    return null;
  }

  @override
  MediaQueryData get mediaQuery {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  }

  @override
  Widget get widget {
    throw UnsupportedError('widget');
  }
}
