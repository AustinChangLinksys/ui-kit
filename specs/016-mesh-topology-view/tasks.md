# Tasks: Mesh Network Topology View

**Input**: Design documents from `/specs/016-mesh-topology-view/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Golden tests included per Constitution 12.2 (Theme × Brightness matrix testing)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Main library**: `lib/src/organisms/topology/`
- **Theme specs**: `lib/src/foundation/theme/design_system/specs/`
- **Tests**: `test/organisms/topology/`
- **Widgetbook**: `widgetbook/lib/stories/organisms/topology/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Directory structure and theme spec scaffolding

- [x] T001 Create topology directory structure in lib/src/organisms/topology/
- [x] T002 Create topology test directory structure in test/organisms/topology/
- [x] T003 [P] Create widgetbook stories directory in widgetbook/lib/stories/organisms/topology/
- [x] T004 [P] Create TopologySpec stub with @TailorMixin() in lib/src/foundation/theme/design_system/specs/topology_style.dart
- [x] T005 [P] Create NodeStyle class with @TailorMixin() in lib/src/foundation/theme/design_system/specs/topology_style.dart
- [x] T006 [P] Create LinkStyle class with @TailorMixin() in lib/src/foundation/theme/design_system/specs/topology_style.dart
- [x] T007 Run build_runner to generate theme tailor code

**Checkpoint**: Directory structure ready, theme specs scaffolded

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core data models and theme integration that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T008 Create MeshNodeType enum in lib/src/organisms/topology/models/mesh_node.dart
- [x] T009 Create MeshNodeStatus enum in lib/src/organisms/topology/models/mesh_node.dart
- [x] T010 [P] Create MeshNode model with Equatable in lib/src/organisms/topology/models/mesh_node.dart
- [x] T011 [P] Create ConnectionType enum in lib/src/organisms/topology/models/mesh_link.dart
- [x] T012 [P] Create SignalQuality enum in lib/src/organisms/topology/models/mesh_link.dart
- [x] T013 Create MeshLink model with Equatable in lib/src/organisms/topology/models/mesh_link.dart
- [x] T014 Create MeshTopology container model in lib/src/organisms/topology/models/mesh_topology.dart
- [x] T015 [P] Implement TopologySpec with all node and link styles in lib/src/foundation/theme/design_system/specs/topology_style.dart
- [x] T016 [P] Implement nodeStyleFor() helper method in TopologySpec
- [x] T017 [P] Implement linkStyleFor() helper method in TopologySpec
- [x] T018 Add TopologySpec to AppDesignTheme in lib/src/foundation/theme/app_design_theme.dart
- [x] T019 [P] Add TopologySpec to GlassDesignTheme in lib/src/foundation/theme/design_system/styles/glass_design_theme.dart
- [x] T020 [P] Add TopologySpec to BrutalDesignTheme in lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart
- [x] T021 [P] Add TopologySpec to FlatDesignTheme in lib/src/foundation/theme/design_system/styles/flat_design_theme.dart
- [x] T022 [P] Add TopologySpec to NeumorphicDesignTheme in lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart
- [x] T023 [P] Add TopologySpec to PixelDesignTheme in lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart
- [x] T024 Run build_runner to regenerate theme code
- [x] T025 Create NodeBuilder abstract interface in lib/src/organisms/topology/nodes/node_builder.dart
- [x] T026 Create nodeBuilders registry map in lib/src/organisms/topology/nodes/node_builder.dart

**Checkpoint**: Foundation ready - all models, enums, and theme specs in place

---

## Phase 3: User Story 1 - View Network Status at a Glance (Priority: P1) 🎯 MVP

**Goal**: Users can instantly see network health through visual animations (breathing Gateway, liquid Extenders)

**Independent Test**: Display static topology with animated nodes showing different states (normal, high-load, offline)

### Golden Tests for User Story 1

- [x] T027 [P] [US1] Create PulseNode golden test for normal state in test/organisms/topology/nodes/pulse_node_golden_test.dart
- [x] T028 [P] [US1] Create PulseNode golden test for high-load state in test/organisms/topology/nodes/pulse_node_golden_test.dart
- [x] T029 [P] [US1] Create PulseNode golden test for offline state in test/organisms/topology/nodes/pulse_node_golden_test.dart
- [x] T030 [P] [US1] Create LiquidNode golden test for low-load state in test/organisms/topology/nodes/liquid_node_golden_test.dart
- [x] T031 [P] [US1] Create LiquidNode golden test for high-load state in test/organisms/topology/nodes/liquid_node_golden_test.dart

### Implementation for User Story 1

- [x] T032 [US1] Implement PulseNode StatefulWidget with breathing animation in lib/src/organisms/topology/nodes/pulse_node.dart
- [x] T033 [US1] Add breathing animation controller with normal (4s) and stressed (1s) periods in lib/src/organisms/topology/nodes/pulse_node.dart
- [x] T034 [US1] Add glow effect using flutter_animate in lib/src/organisms/topology/nodes/pulse_node.dart
- [x] T035 [US1] Add offline state handling (stop animation, grayscale) in lib/src/organisms/topology/nodes/pulse_node.dart
- [x] T036 [US1] Implement WavePainter CustomPainter for liquid animation in lib/src/organisms/topology/nodes/liquid_node.dart
- [x] T037 [US1] Implement LiquidNode StatefulWidget with wave animation in lib/src/organisms/topology/nodes/liquid_node.dart
- [x] T038 [US1] Add load-based water level calculation (0-100%) in lib/src/organisms/topology/nodes/liquid_node.dart
- [x] T039 [US1] Add turbulence effect at high load (>70%) in lib/src/organisms/topology/nodes/liquid_node.dart
- [x] T040 [US1] Add color interpolation (blue → orange/red) based on load in lib/src/organisms/topology/nodes/liquid_node.dart
- [x] T041 [US1] Implement PulseNodeBuilder in lib/src/organisms/topology/nodes/node_builder.dart
- [x] T042 [US1] Implement LiquidNodeBuilder in lib/src/organisms/topology/nodes/node_builder.dart
- [x] T043 [US1] Create status change debounce logic (500ms) in lib/src/organisms/topology/nodes/pulse_node.dart
- [x] T044 [US1] Update golden test baselines after implementation
- [x] T045 [P] [US1] Create PulseNode Widgetbook story in widgetbook/lib/stories/organisms/topology/pulse_node_story.dart
- [x] T046 [P] [US1] Create LiquidNode Widgetbook story in widgetbook/lib/stories/organisms/topology/liquid_node_story.dart

**Checkpoint**: Gateway and Extender nodes render with health-indicating animations

---

## Phase 4: User Story 2 - Responsive View Switching (Priority: P1)

**Goal**: Automatic Tree View (mobile <600px) and Topology View (desktop ≥600px) switching

**Independent Test**: Resize browser window across 600px breakpoint and verify view mode switches

### Golden Tests for User Story 2

- [x] T047 [P] [US2] Create AppTopology golden test for Tree View mode in test/organisms/topology/app_topology_golden_test.dart
- [x] T048 [P] [US2] Create AppTopology golden test for Graph View mode in test/organisms/topology/app_topology_golden_test.dart

### Implementation for User Story 2

- [x] T049 [US2] Create TopologyTreeView widget stub in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T050 [US2] Create TopologyGraphView widget stub in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T051 [US2] Implement AppTopology main entry point with LayoutBuilder in lib/src/organisms/topology/app_topology.dart
- [x] T052 [US2] Add 600px breakpoint detection in lib/src/organisms/topology/app_topology.dart
- [x] T053 [US2] Add AnimatedSwitcher for smooth view transitions (300ms) in lib/src/organisms/topology/app_topology.dart
- [x] T054 [US2] Add TopologyViewMode enum and viewMode parameter override in lib/src/organisms/topology/app_topology.dart
- [x] T055 [US2] Add loading skeleton support when topology is empty in lib/src/organisms/topology/app_topology.dart
- [x] T056 [US2] Add emptyStateWidget parameter for custom empty state in lib/src/organisms/topology/app_topology.dart
- [x] T056.5 [US2] Export onTopologyChanged callback pattern in lib/src/organisms/topology/app_topology.dart for FR-023 real-time updates
- [x] T057 [US2] Update golden test baselines after implementation
- [x] T058 [P] [US2] Create AppTopology Widgetbook story with view mode knob in widgetbook/lib/stories/organisms/topology/app_topology_story.dart

**Checkpoint**: AppTopology automatically switches views based on viewport width

---

## Phase 5: User Story 3 - Identify Connection Quality (Priority: P2)

**Goal**: Visual link indicators show connection quality (Ethernet solid, WiFi colored by RSSI)

**Independent Test**: Display links with different RSSI values and connection types

### Golden Tests for User Story 3

- [x] T059 [P] [US3] Create LinkRenderer golden test for Ethernet links in test/organisms/topology/links/link_renderer_golden_test.dart
- [x] T060 [P] [US3] Create LinkRenderer golden test for WiFi strong signal in test/organisms/topology/links/link_renderer_golden_test.dart
- [x] T061 [P] [US3] Create LinkRenderer golden test for WiFi weak signal in test/organisms/topology/links/link_renderer_golden_test.dart

### Implementation for User Story 3

- [x] T062 [US3] Create LinkPainter CustomPainter in lib/src/organisms/topology/links/link_renderer.dart
- [x] T063 [US3] Implement solid line drawing for Ethernet links in lib/src/organisms/topology/links/link_renderer.dart
- [x] T064 [US3] Implement dashed line drawing for WiFi links in lib/src/organisms/topology/links/link_renderer.dart
- [x] T065 [US3] Add RSSI-to-color mapping (green/yellow/red) in lib/src/organisms/topology/links/link_renderer.dart
- [x] T066 [US3] Create FlowAnimation widget for WiFi link animation in lib/src/organisms/topology/links/link_renderer.dart (combined into link_renderer.dart)
- [x] T067 [US3] Add throughput-based animation speed control in lib/src/organisms/topology/links/link_renderer.dart (combined into link_renderer.dart)
- [x] T068 [US3] Add unknown signal (gray) fallback style in lib/src/organisms/topology/links/link_renderer.dart
- [x] T069 [US3] Update golden test baselines after implementation
- [x] T069.5 [P] [US3] Create LinkRenderer Widgetbook story in widgetbook/lib/stories/organisms/topology/link_renderer_story.dart

**Checkpoint**: All link types render with appropriate visual styles and animations ✅

---

## Phase 6: User Story 4 - Explore Connected Clients (Priority: P2)

**Goal**: Client devices orbit parent nodes as satellites with hover interaction

**Independent Test**: Display client devices orbiting a router node with hover pause

### Golden Tests for User Story 4

- [x] T070 [P] [US4] Create OrbitNode golden test for idle state in test/organisms/topology/nodes/orbit_node_golden_test.dart
- [x] T071 [P] [US4] Create OrbitNode golden test for hovered/expanded state in test/organisms/topology/nodes/orbit_node_golden_test.dart

### Implementation for User Story 4

- [x] T072 [US4] Create OrbitNode StatefulWidget in lib/src/organisms/topology/nodes/orbit_node.dart
- [x] T073 [US4] Implement orbit position calculation using angle and radius in lib/src/organisms/topology/nodes/orbit_node.dart
- [x] T074 [US4] Add shared ticker support for synchronized orbits in lib/src/organisms/topology/nodes/orbit_node.dart (via OrbitNodeGroup)
- [x] T075 [US4] Implement hover detection with isPaused parameter in lib/src/organisms/topology/nodes/orbit_node.dart
- [x] T076 [US4] Implement details expansion on hover with isExpanded parameter in lib/src/organisms/topology/nodes/orbit_node.dart
- [x] T077 [US4] Add smooth resume animation when hover ends in lib/src/organisms/topology/nodes/orbit_node.dart
- [x] T078 [US4] Implement OrbitNodeBuilder in lib/src/organisms/topology/nodes/node_builder.dart
- [x] T079 [US4] Implement ClientVisibility.clustered mode (auto-group >20 clients) in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T080 [US4] Add cluster badge UI and tap-to-expand interaction in lib/src/organisms/topology/nodes/cluster_badge.dart
- [x] T081 [US4] Update golden test baselines after implementation
- [x] T082 [P] [US4] Create OrbitNode Widgetbook story in widgetbook/lib/stories/organisms/topology/orbit_node_story.dart

**Checkpoint**: Client nodes orbit with interactive hover behavior ✅

---

## Phase 7: User Story 5 - Manage Device via Tree View (Priority: P2)

**Goal**: Tree View provides device management actions (view details, rename, restart)

**Independent Test**: Display device cards with action buttons and verify interactions

### Implementation for User Story 5

- [x] T083 [US5] Create TreeNodeCard widget in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart (implemented as _TreeNodeTile inline)
- [x] T084 [US5] Add device info display (name, status, load) in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T085 [US5] Add tap handler for detail expansion in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart (onNodeTap callback)
- [x] T086 [US5] ~~Add rename action with inline text editor~~ → Replaced by generic NodeMenuBuilder interface (upper layer defines actions)
- [x] T087 [US5] ~~Add restart action button for extenders~~ → Replaced by generic NodeMenuBuilder interface (upper layer defines actions)
- [x] T088 [US5] Wire NodeMenuBuilder callback for context menu in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T089 [US5] Wire onNodeMenuSelected callback for menu actions in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T090 [P] [US5] Create TreeNodeCard Widgetbook story → Covered by TopologyTreeView story (T097), node tile is inline

**Checkpoint**: Tree View provides context menu actions (rename/restart via custom menu builder)

---

## Phase 8: User Story 6 - Understand Network Hierarchy (Priority: P3)

**Goal**: Visual hierarchy (Gateway → Extender → Client) with guide lines

**Independent Test**: Display multi-level hierarchy with visual guide lines

### Implementation for User Story 6

- [x] T091 [US6] Create TreeGuideLine widget in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart (implemented as _VerticalLinePainter and _ConnectorPainter inline)
- [x] T092 [US6] Implement GuideLinePainter for vertical/horizontal lines in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T093 [US6] Add isLast parameter for connector variations in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T094 [US6] Implement full TopologyTreeView with hierarchy layout in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T095 [US6] Add depth-based indentation in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T096 [US6] Build node tree from MeshTopology data in lib/src/organisms/topology/views/tree_view/topology_tree_view.dart
- [x] T097 [P] [US6] Create TopologyTreeView Widgetbook story in widgetbook/lib/stories/organisms/topology/tree_view_story.dart

**Checkpoint**: Tree View displays clear hierarchical structure with guide lines ✅

---

## Phase 9: Graph View Implementation (Cross-cutting for US1-US4)

**Goal**: Complete 2D topology map with concentric layout for desktop

### Implementation for Graph View

- [x] T098 Create ConcentricLayout algorithm in lib/src/organisms/topology/layouts/concentric_layout.dart
- [x] T099 Implement Gateway-at-center positioning in lib/src/organisms/topology/layouts/concentric_layout.dart
- [x] T100 Implement Extender ring positioning at radius R1 in lib/src/organisms/topology/layouts/concentric_layout.dart
- [x] T101 Implement Client orbit positioning at radius R2 from parent in lib/src/organisms/topology/layouts/concentric_layout.dart
- [x] T101.5 Create HorizontalLayout algorithm for daisy chain topologies in lib/src/organisms/topology/layouts/horizontal_layout.dart
- [x] T101.6 Create TopologyAnalyzer for auto layout selection in lib/src/organisms/topology/layouts/horizontal_layout.dart
- [x] T102 Create TopologyNodeRenderer coordinator in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart (implemented inline as _buildNode)
- [x] T103 Implement full TopologyGraphView with InteractiveViewer in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T104 Add pan and zoom support (0.3x - 3.0x) in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T105 Add link layer behind nodes using Stack in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart (via _LinksPainter)
- [x] T106 Add ClientVisibility support (always, onHover, collapsed) in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T107 Wire onNodeTap and onNodeMenuSelected callbacks in lib/src/organisms/topology/views/graph_view/topology_graph_view.dart
- [x] T108 [P] Create TopologyGraphView Widgetbook story in widgetbook/lib/stories/organisms/topology/graph_view_story.dart

**Checkpoint**: Graph View displays complete 2D topology with pan/zoom ✅

---

## Phase 10: Polish & Cross-Cutting Concerns

**Purpose**: Accessibility, reduced motion, semantics, final validation

- [x] T109 Add Semantics labels to all node widgets in lib/src/organisms/topology/nodes/ (PulseNode, LiquidNode, OrbitNode)
- [x] T110 Ensure touch targets meet minimum size (44x44 iOS, 48x48 Android) in all nodes (node size 64px default)
- [x] T111 Add reduced motion preference check in lib/src/organisms/topology/app_topology.dart (MediaQuery.disableAnimations)
- [x] T112 Create static fallback rendering when animations disabled in lib/src/organisms/topology/nodes/ (enableAnimation=false)
- [x] T113 Export public API from lib/src/organisms/topology/topology.dart
- [x] T114 Add topology exports to lib/ui_kit.dart
- [x] T115 [P] Create integration golden test for full topology in test/organisms/topology/app_topology_golden_test.dart
- [x] T115.5 [P] Create 50-client stress test validating SC-006 responsiveness in test/organisms/topology/app_topology_stress_test.dart
- [x] T116 Run all golden tests and update baselines
- [x] T117 Validate quickstart.md examples work correctly
- [x] T118 Run flutter analyze and fix any issues
- [x] T119 Verify all Widgetbook stories render correctly in all themes

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-8)**: All depend on Foundational phase completion
  - US1 and US2 can proceed in parallel (independent)
  - US3-US6 can proceed after US1/US2 or in parallel
- **Graph View (Phase 9)**: Depends on US1 (nodes), US3 (links), US4 (orbits)
- **Polish (Phase 10)**: Depends on all phases being complete

### User Story Dependencies

- **User Story 1 (P1)**: Foundation only - Node animations
- **User Story 2 (P1)**: Foundation only - View switching
- **User Story 3 (P2)**: Foundation only - Link rendering
- **User Story 4 (P2)**: Foundation only - Client orbits
- **User Story 5 (P2)**: US6 (hierarchy) - Tree management actions
- **User Story 6 (P3)**: Foundation only - Tree hierarchy

### Within Each User Story

- Golden tests FIRST (verify they fail before implementation)
- Models/painters before widgets
- Widgets before integration
- Update golden baselines after implementation
- Widgetbook story after widget complete

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Golden tests within a story marked [P] can run in parallel
- US1 and US2 can be implemented in parallel after Foundation
- US3, US4, US5, US6 can be implemented in parallel after Foundation

---

## Parallel Example: User Story 1

```bash
# Launch all golden tests for US1 together:
Task: "Create PulseNode golden test for normal state"
Task: "Create PulseNode golden test for high-load state"
Task: "Create PulseNode golden test for offline state"
Task: "Create LiquidNode golden test for low-load state"
Task: "Create LiquidNode golden test for high-load state"

# After golden tests, launch Widgetbook stories in parallel:
Task: "Create PulseNode Widgetbook story"
Task: "Create LiquidNode Widgetbook story"
```

---

## Implementation Strategy

### MVP First (User Stories 1 + 2)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: US1 - Node animations
4. Complete Phase 4: US2 - View switching
5. **STOP and VALIDATE**: Basic topology renders with animated nodes
6. Deploy/demo if ready

### Incremental Delivery

1. **Setup + Foundational** → Foundation ready
2. **Add US1** → Gateway/Extender animations visible
3. **Add US2** → Responsive view switching works → **MVP!**
4. **Add US3** → Connection quality visible
5. **Add US4** → Client satellites orbit
6. **Add US5** → Device management in Tree View
7. **Add US6** → Full hierarchy display
8. **Add Phase 9** → Complete Graph View
9. **Add Phase 10** → Polish and accessibility

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (nodes) + User Story 2 (view switching)
   - Developer B: User Story 3 (links) + User Story 4 (orbits)
   - Developer C: User Story 5 (tree management) + User Story 6 (hierarchy)
3. Team integrates for Graph View (Phase 9)
4. Team completes Polish (Phase 10)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Golden tests use buildThemeMatrix for 8-variant coverage
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Animation tests must use TickerMode(enabled: false) per Constitution B.3

---

## Domain Separation (Completed)

The topology module has been reorganized into clear domain layers:

```
topology/
├── models/          # Data models (MeshNode, MeshLink, MeshTopology)
│   └── models.dart  # barrel file
├── types/           # Type definitions (NodeMenuBuilder, TopologyViewMode, ClientVisibility)
│   └── topology_types.dart
├── nodes/           # Node widgets (PulseNode, LiquidNode, OrbitNode)
│   └── nodes.dart   # barrel file
├── views/           # View widgets
│   ├── views.dart   # barrel file
│   ├── graph_view/
│   └── tree_view/
├── layouts/         # Layout algorithms (ConcentricLayout, HorizontalLayout)
│   └── layouts.dart # barrel file
├── links/           # Link rendering
│   └── links.dart   # barrel file
├── app_topology.dart  # Main entry point widget
└── topology.dart      # Main barrel file
```

---

## Progress Summary

| Phase | Status | Completion |
|-------|--------|------------|
| Phase 1: Setup | ✅ Complete | 7/7 |
| Phase 2: Foundational | ✅ Complete | 19/19 |
| Phase 3: US1 - Node Animations | ✅ Complete | 20/20 |
| Phase 4: US2 - View Switching | ✅ Complete | 12/12 |
| Phase 5: US3 - Link Quality | ✅ Complete | 12/12 |
| Phase 6: US4 - Client Orbits | ✅ Complete | 13/13 |
| Phase 7: US5 - Tree Management | ✅ Complete | 8/8 |
| Phase 8: US6 - Hierarchy | ✅ Complete | 7/7 |
| Phase 9: Graph View | ✅ Complete | 13/13 |
| Phase 10: Polish | ✅ Complete | 11/11 |

**All Tasks Complete!** 🎉
