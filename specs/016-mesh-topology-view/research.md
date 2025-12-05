# Research: Mesh Network Topology View

**Feature**: 016-mesh-topology-view
**Date**: 2025-12-05
**Phase**: 0 - Design Decisions

## Design Decisions Log

### DR-001: Node Type Differentiation Strategy

**Question**: How should different node types (Gateway, Extender, Client) be rendered without violating Constitution's no-runtime-type-check rule?

**Options Considered**:
1. **Switch on enum** - `switch (node.type) { case gateway: ... }`
2. **Renderer Pattern** - Abstract `NodeBuilder` interface with concrete implementations
3. **Strategy Map** - `Map<MeshNodeType, NodeBuilder>` lookup

**Decision**: Option 2 + 3 combined - Renderer Pattern with Strategy Map

**Rationale**:
- Constitution 6.1 prohibits `if (theme is X)` checks but allows data-driven dispatch
- Strategy Map provides O(1) lookup without branching logic
- Each `NodeBuilder` encapsulates its own animation and rendering logic
- Adding new node types requires only adding a new builder + map entry

**Implementation**:
```dart
final nodeBuilders = <MeshNodeType, NodeBuilder>{
  MeshNodeType.gateway: PulseNodeBuilder(),
  MeshNodeType.extender: LiquidNodeBuilder(),
  MeshNodeType.client: OrbitNodeBuilder(),
};

// Usage - no branching
final builder = nodeBuilders[node.type]!;
return builder.build(context, node, style);
```

---

### DR-002: Animation Architecture

**Question**: Should animations be managed by individual nodes or a central coordinator?

**Options Considered**:
1. **Individual StatefulWidgets** - Each node manages its own `AnimationController`
2. **Central TickerProvider** - Single ticker drives all animations
3. **Hybrid** - Breathing/waves local, orbit timing global

**Decision**: Option 3 - Hybrid approach

**Rationale**:
- Breathing (PulseNode) is independent per node - local controller
- Wave simulation (LiquidNode) is independent per node - local controller
- Orbit (OrbitNode) must be synchronized across siblings - shared ticker
- Reduces ticker overhead from 50 controllers to ~10

**Implementation**:
- `PulseNode` and `LiquidNode` extend `SingleTickerProviderStateMixin`
- `TopologyGraphView` provides shared `TickerProvider` for orbit animations
- Orbit angle calculated from global time, not individual controllers

---

### DR-003: View Mode Switching

**Question**: How to implement responsive Tree/Graph view switching at 600px breakpoint?

**Options Considered**:
1. **MediaQuery in build()** - Check width and return different widget
2. **LayoutBuilder** - Rebuild on constraint changes
3. **AnimatedSwitcher + LayoutBuilder** - Smooth transition between views

**Decision**: Option 3 - AnimatedSwitcher + LayoutBuilder

**Rationale**:
- FR-003 requires "smooth transition" between views
- `LayoutBuilder` detects constraint changes immediately
- `AnimatedSwitcher` provides cross-fade/slide transition
- Transition duration: 300ms per SC-003

**Implementation**:
```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth >= 600;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isWideScreen
          ? TopologyGraphView(key: const Key('graph'), ...)
          : TopologyTreeView(key: const Key('tree'), ...),
    );
  },
)
```

---

### DR-004: Link Rendering Strategy

**Question**: How to render connections between nodes with flow animations?

**Options Considered**:
1. **CustomPainter on Canvas** - Draw lines directly on canvas layer
2. **Stack with Positioned widgets** - Position line widgets between nodes
3. **CustomMultiChildLayout** - Custom layout with line painting delegate

**Decision**: Option 1 - CustomPainter on Canvas

**Rationale**:
- Links are purely decorative, no hit testing needed
- CustomPainter performs best for many animated lines
- Can render behind nodes using Stack layering
- Flow animation achieved via `dashOffset` animation

**Implementation**:
```dart
class LinkPainter extends CustomPainter {
  final List<MeshLink> links;
  final Map<String, Offset> nodePositions;
  final double flowOffset; // Animated 0.0 to 1.0

  @override
  void paint(Canvas canvas, Size size) {
    for (final link in links) {
      final start = nodePositions[link.sourceId]!;
      final end = nodePositions[link.targetId]!;
      final paint = _getLinkPaint(link);

      if (link.connectionType == ConnectionType.wifi) {
        _drawDashedLine(canvas, start, end, paint, flowOffset);
      } else {
        canvas.drawLine(start, end, paint);
      }
    }
  }
}
```

---

### DR-005: Liquid Wave Implementation

**Question**: How to create realistic water level visualization in LiquidNode?

**Options Considered**:
1. **Rive animation** - Pre-designed water animation
2. **Lottie** - After Effects exported animation
3. **CustomPainter with math** - Procedural sine wave

**Decision**: Option 3 - CustomPainter with procedural math

**Rationale**:
- Constitution 8.1 prohibits Lottie
- Rive requires asset file per load level (not scalable)
- Procedural math allows continuous load → wave mapping
- Parameters controllable via TopologySpec

**Implementation**:
```dart
class WavePainter extends CustomPainter {
  final double load; // 0.0 to 1.0
  final double time; // Animation progress
  final Color lowColor;
  final Color highColor;

  @override
  void paint(Canvas canvas, Size size) {
    final waterLevel = size.height * (1 - load);
    final path = Path()..moveTo(0, waterLevel);

    // Primary wave
    for (var x = 0.0; x <= size.width; x += 1) {
      final y = waterLevel +
        sin((x / size.width * 2 * pi) + time) * amplitude +
        (load > 0.7 ? _turbulence(x, time) : 0);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, Paint()..color = Color.lerp(lowColor, highColor, load)!);
  }
}
```

---

### DR-006: Client Clustering for Scale

**Question**: How to handle >20 clients without visual clutter?

**Options Considered**:
1. **Pagination** - Show 10 at a time with next/prev
2. **Clustering** - Group into expandable clusters
3. **Zoom levels** - Different detail at different zoom

**Decision**: Option 2 - Clustering with count indicator

**Rationale**:
- Matches spec edge case: "Group clients into clusters with count indicator"
- Maintains spatial relationship (cluster orbits parent)
- Tap to expand shows individual devices
- No pagination UI needed

**Implementation**:
```dart
const clusterThreshold = 20;

List<OrbitItem> buildOrbitItems(List<MeshNode> clients) {
  if (clients.length <= clusterThreshold) {
    return clients.map((c) => OrbitItem.device(c)).toList();
  }

  // Group by device type or connection quality
  final groups = groupBy(clients, (c) => c.deviceCategory);
  return groups.entries.map((e) =>
    OrbitItem.cluster(
      label: e.key,
      count: e.value.length,
      children: e.value,
    )
  ).toList();
}
```

---

### DR-007: Offline State Visual Treatment

**Question**: How to visually indicate offline nodes across all themes?

**Options Considered**:
1. **Grayscale filter** - Apply ColorFilter to entire node
2. **Style variant** - Separate `NodeStyle.offline` in theme
3. **Opacity reduction** - Reduce opacity to 0.5

**Decision**: Option 2 - Dedicated style variant in theme

**Rationale**:
- Constitution 4.1 requires token-first approach
- Different themes may want different offline treatments:
  - Glass: grayscale + reduced blur
  - Brutal: sharp edges + cross-hatch pattern
  - Pixel: glitch effect
- Style variant allows per-theme customization

**Implementation**:
```dart
@TailorMixin()
class NodeStyle {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double blurStrength;
  final double glowRadius;
  // ... animation params
}

// In TopologySpec
final NodeStyle gatewayNormalStyle;
final NodeStyle gatewayStressedStyle;
final NodeStyle gatewayOfflineStyle;  // Dedicated offline variant
```

---

### DR-008: Pan/Zoom Implementation

**Question**: How to implement pan and zoom in Graph View?

**Options Considered**:
1. **GestureDetector + Transform** - Manual gesture handling
2. **InteractiveViewer** - Flutter's built-in pan/zoom widget
3. **Custom with matrix4** - Full control over transforms

**Decision**: Option 2 - InteractiveViewer

**Rationale**:
- InteractiveViewer handles all gesture complexity
- Supports bounded/unbounded panning
- Built-in momentum scrolling
- Less code, fewer bugs

**Implementation**:
```dart
InteractiveViewer(
  boundaryMargin: const EdgeInsets.all(100),
  minScale: 0.5,
  maxScale: 3.0,
  child: CustomPaint(
    painter: TopologyPainter(...),
    child: Stack(children: nodeWidgets),
  ),
)
```

---

### DR-009: Tree View Guide Lines

**Question**: How to render hierarchical guide lines in Tree View?

**Options Considered**:
1. **Container borders** - Use left/bottom borders
2. **CustomPainter** - Draw lines in paint layer
3. **Dedicated GuideLineWidget** - Reusable widget with style

**Decision**: Option 3 - Dedicated GuideLineWidget

**Rationale**:
- Guide line styling varies by theme (solid vs dotted)
- Reusable across tree structures
- Easier to test in isolation
- Color comes from TopologySpec

**Implementation**:
```dart
class TreeGuideLine extends StatelessWidget {
  final bool isLast; // Last sibling has no continuation line
  final int depth;

  @override
  Widget build(BuildContext context) {
    final spec = Theme.of(context).extension<AppDesignTheme>()!.topologySpec;
    return CustomPaint(
      painter: GuideLinePainter(
        color: spec.guideLineColor,
        style: spec.guideLineStyle, // solid, dashed, dotted
        isLast: isLast,
      ),
    );
  }
}
```

---

### DR-010: State Update Debouncing

**Question**: How to handle rapid status changes without jarring visuals?

**Options Considered**:
1. **Timer debounce** - Delay state application by 500ms
2. **Animation lerp** - Smoothly animate between states
3. **Both** - Debounce + animate

**Decision**: Option 3 - Debounce + animate

**Rationale**:
- Spec edge case: "Debounce animations to prevent jarring visual updates (minimum 500ms between state changes)"
- Timer prevents rapid flicker
- Animation provides smooth transition when state does change

**Implementation**:
```dart
class _PulseNodeState extends State<PulseNode> {
  MeshNodeStatus _displayedStatus = MeshNodeStatus.normal;
  Timer? _debounceTimer;

  @override
  void didUpdateWidget(PulseNode oldWidget) {
    if (widget.node.status != oldWidget.node.status) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        setState(() => _displayedStatus = widget.node.status);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // Use _displayedStatus for visuals
    );
  }
}
```

---

## Technology Choices Summary

| Concern | Choice | Constitution Reference |
|---------|--------|----------------------|
| State Management | StatefulWidget (UI transient) | Section 5.2 |
| Animation | flutter_animate | Section 8.1 |
| Wave Rendering | CustomPainter | Section 11 (Performance) |
| Pan/Zoom | InteractiveViewer | Built-in Flutter |
| Theme Integration | @TailorMixin | Section 4.4 |
| Testing | alchemist golden tests | Section 12.2 |

## Open Questions (Resolved)

1. ~~Should orbit speed vary by device type?~~ → No, uniform speed for visual consistency
2. ~~Should offline nodes still orbit?~~ → Yes, but greyed out (maintains spatial awareness)
3. ~~Maximum zoom level for Graph View?~~ → 3.0x (balance between detail and performance)
