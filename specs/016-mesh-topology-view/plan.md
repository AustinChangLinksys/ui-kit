# Implementation Plan: Mesh Network Topology View

**Branch**: `016-mesh-topology-view` | **Date**: 2025-12-05 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/016-mesh-topology-view/spec.md`

## Summary

Transform network device management from a static list into an **Organic Living System** visualization. The implementation provides dual view modes (Tree View for mobile, Topology View for desktop) with procedural animations that convey network health through visual metaphors: breathing Gateway nodes, liquid-level Extenders, and orbiting client satellites. The architecture follows the Renderer Pattern with theme-driven node builders, ensuring Constitution compliance through Data-Driven Strategy.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x (SDK >=3.0.0 <4.0.0, Flutter >=3.13.0)
**Primary Dependencies**: flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing)
**Storage**: N/A (UI library, no persistence - data provided by external API)
**Testing**: flutter test, alchemist golden tests (4 themes × 2 brightness = 8 combinations)
**Target Platform**: iOS/Android (mobile), Web/Desktop (responsive)
**Project Type**: Flutter UI Component Library (single package)
**Performance Goals**: 60fps animations, <300ms view transitions, smooth with 50+ client devices
**Constraints**: No business logic, no external state management, theme-driven rendering
**Scale/Scope**: 1 Gateway, 0-8 Extenders, 0-50 Clients per network topology

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Section | Requirement | Status | Implementation Strategy |
|---------|-------------|--------|------------------------|
| **2.1 Physical Isolation** | Independent Dart Package | ✅ PASS | Component lives in `lib/src/organisms/topology/` |
| **2.2 Dependency Hygiene** | No forbidden deps | ✅ PASS | Uses only flutter, flutter_animate (allowed) |
| **3.1 IoC** | Components ask "How", not "Who" | ✅ PASS | Node styles come from `TopologySpec` in Theme |
| **3.2 DDS** | No runtime type checks | ✅ PASS | Renderer Pattern with `NodeBuilder` data, no `if (theme is X)` |
| **3.3 Zero Internal Defaults** | Fail fast on missing theme | ✅ PASS | `AppDesignTheme` must provide `TopologySpec` |
| **4.1 Token-First** | No hardcoded colors | ✅ PASS | All colors from `TopologySpec` |
| **5.1 AppSurface** | Compose AppSurface | ✅ PASS | All nodes compose `AppSurface` for base rendering |
| **5.2 Dumb Components** | No business state | ✅ PASS | Data via constructor, events via callbacks |
| **6.1 No Runtime Type Checks** | Avoid `if (theme is X)` | ✅ PASS | Node visuals defined by `NodeStyle` specs |
| **6.2 Zero-Touch Policy** | New styles = no component changes | ✅ PASS | Add new `TopologySpec` variant without touching widgets |
| **12.1 Widgetbook** | UseCase with Knobs | ✅ PLANNED | Stories for Tree/Topology views with state controls |
| **12.2 Golden Tests** | Theme × Brightness matrix | ✅ PLANNED | 8 scenarios per component state |

## Project Structure

### Documentation (this feature)

```text
specs/016-mesh-topology-view/
├── plan.md              # This file
├── research.md          # Phase 0: Design decisions
├── data-model.md        # Phase 1: Entity definitions
├── quickstart.md        # Phase 1: Copy-paste usage guide
├── contracts/           # Phase 1: API contracts
│   ├── mesh_node_api.md
│   └── topology_spec_api.md
└── tasks.md             # Phase 2 output (/speckit.tasks)
```

### Source Code (repository root)

```text
lib/src/
├── foundation/
│   └── theme/
│       └── design_system/
│           └── specs/
│               └── topology_style.dart          # TopologySpec, NodeStyle, LinkStyle
├── organisms/
│   └── topology/
│       ├── app_topology.dart                    # Main entry point (Dumb Component)
│       ├── models/
│       │   ├── mesh_node.dart                   # MeshNode, MeshNodeType, MeshNodeStatus
│       │   └── mesh_link.dart                   # MeshLink, ConnectionType
│       ├── views/
│       │   ├── tree_view/
│       │   │   ├── topology_tree_view.dart      # Mobile Tree View
│       │   │   └── tree_node_card.dart          # Device card with guide lines
│       │   └── graph_view/
│       │       ├── topology_graph_view.dart     # Desktop 2D Map View
│       │       └── concentric_layout.dart       # Gateway-centered layout
│       ├── nodes/
│       │   ├── node_builder.dart                # Abstract NodeBuilder interface
│       │   ├── pulse_node.dart                  # Gateway breathing animation
│       │   ├── liquid_node.dart                 # Extender water level animation
│       │   └── orbit_node.dart                  # Client satellite animation
│       ├── links/
│       │   ├── link_renderer.dart               # Link drawing strategies
│       │   └── flow_animation.dart              # WiFi flow effect
│       └── renderers/
│           └── topology_node_renderer.dart      # Renderer Pattern coordinator

test/
└── organisms/
    └── topology/
        ├── app_topology_test.dart               # Unit tests
        ├── app_topology_golden_test.dart        # Golden test matrix
        ├── nodes/
        │   ├── pulse_node_test.dart
        │   ├── liquid_node_test.dart
        │   └── orbit_node_test.dart
        └── views/
            ├── tree_view_test.dart
            └── graph_view_test.dart

widgetbook/lib/stories/
└── organisms/
    └── topology/
        ├── app_topology_story.dart
        ├── tree_view_story.dart
        └── graph_view_story.dart
```

**Structure Decision**: Follows Atomic Design with topology components in `organisms/` tier due to complexity. Uses Renderer Pattern to separate node visualization logic from container widget.

## Architecture Decisions

### D1: Renderer Pattern for Node Types

**Decision**: Use Renderer Pattern with `NodeBuilder` interface

**Rationale**: Constitution Section 6.1 prohibits runtime type checks. Instead of `if (node.type == gateway)`, define `NodeBuilder` interface that each node type implements.

```dart
abstract class NodeBuilder {
  Widget build(BuildContext context, MeshNode node, NodeStyle style);
}

class PulseNodeBuilder implements NodeBuilder { ... }
class LiquidNodeBuilder implements NodeBuilder { ... }
class OrbitNodeBuilder implements NodeBuilder { ... }
```

### D2: TopologySpec for Theme Integration

**Decision**: Create `TopologySpec` as `ThemeExtension` containing all visual parameters

**Rationale**: Constitution Section 4.1 requires all visual properties from Theme. `TopologySpec` provides:
- `NodeStyle` per node type (Gateway, Extender, Client)
- `LinkStyle` per connection type (Ethernet, WiFi)
- Animation parameters (breathing rate, wave frequency)

### D3: Concentric Layout for Graph View

**Decision**: Custom concentric layout algorithm (Gateway → Extenders → Clients)

**Rationale**: No external graph layout library needed. Simple radial positioning:
- Level 0: Gateway at center
- Level 1: Extenders at radius R1
- Level 2: Clients orbiting their parent at radius R2

### D4: flutter_animate for Procedural Animations

**Decision**: Use `flutter_animate` for breathing and flow effects

**Rationale**: Constitution Section 8.1 approves flutter_animate for micro-interactions. Provides:
- `FadeEffect` + `ScaleEffect` for breathing
- `CustomEffect` for wave simulation
- Built-in duration and curve controls

### D5: StatefulWidget for UI Transient State

**Decision**: Use `StatefulWidget` for animation controllers, pan/zoom state

**Rationale**: Constitution Section 5.2 allows UI transient state. No external state management (Bloc/Riverpod) needed for:
- `AnimationController` for breathing/orbiting
- `TransformationController` for pan/zoom

## Complexity Tracking

> No violations. All features achievable within Constitution boundaries.

| Item | Complexity Level | Mitigation |
|------|-----------------|------------|
| Liquid wave animation | Medium | Use CustomPainter with sine wave math |
| Orbit animation | Medium | Global vsync ticker + transform matrix |
| 50+ client clustering | Medium | Group clients when count > threshold |
| Pan/zoom gestures | Low | `InteractiveViewer` widget |

## Animation Specifications

### Pulse Node (Gateway)

```dart
// Breathing parameters from TopologySpec
breathingPeriod: Duration(seconds: 4),  // Normal state
breathingPeriodStressed: Duration(seconds: 1),  // High-load state
glowRadius: 20.0,
glowColor: theme.topologySpec.gatewayGlowColor,
```

### Liquid Node (Extender)

```dart
// Wave simulation using CustomPainter
waveFrequency: 2.0,  // Waves per width
waveAmplitude: load * 10.0,  // Amplitude scales with load
turbulence: load > 0.7 ? 0.5 : 0.0,  // Adds noise when stressed
fillColor: lerpColor(lowLoadColor, highLoadColor, load),
```

### Orbit Node (Client)

```dart
// Satellite motion
orbitRadius: 60.0,
orbitPeriod: Duration(seconds: 10),
pauseOnHover: true,
expandDetailsOnHover: true,
```

## Link Visual Mapping

| Connection Type | RSSI Range | Visual Style |
|-----------------|------------|--------------|
| Ethernet | N/A | Solid thick line, neutral color |
| WiFi Strong | > -50 dBm | Green dashed, fast flow animation |
| WiFi Medium | -50 to -70 dBm | Yellow dashed, medium flow |
| WiFi Weak | < -70 dBm | Red dashed, slow flow animation |
| Unknown | null | Gray dashed, no animation |

## Testing Strategy

### Golden Test Matrix

Each node type × 4 themes × 2 brightness modes:
- `pulse_node_normal.png` (8 variants)
- `pulse_node_stressed.png` (8 variants)
- `pulse_node_offline.png` (8 variants)
- `liquid_node_low_load.png` (8 variants)
- `liquid_node_high_load.png` (8 variants)
- `orbit_node_idle.png` (8 variants)
- `orbit_node_hovered.png` (8 variants)

### Animation Freezing

Per Constitution B.3, animations frozen for golden tests:
```dart
goldenTest(
  'pulse_node_normal',
  builder: () => buildThemeMatrix(
    child: TickerMode(
      enabled: false,
      child: PulseNode(status: MeshNodeStatus.normal),
    ),
  ),
);
```

## Next Steps

1. `/speckit.tasks` - Generate task breakdown from this plan
2. Implementation following task order
3. Golden test validation
4. Widgetbook story creation
