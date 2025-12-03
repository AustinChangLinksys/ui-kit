# Theme Implementation Checklist (T002)

**Purpose**: Track implementation of semantic surfaces across all 5 design themes
**Reference**: plan.md section 1.2
**Date**: 2025-12-03

---

## Glass Theme Implementation

File: `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`

### surfaceSecondary - Light Mode
- [ ] backgroundColor: `scheme.primary.withValues(alpha: 0.12)` ✓
- [ ] blur: `15.0` ✓
- [ ] border: white with `alpha: 0.3` ✓
- [ ] Visual intent: "Denser glass" indicating selection ✓

### surfaceSecondary - Dark Mode
- [ ] backgroundColor: `scheme.primary.withValues(alpha: 0.25)` ✓
- [ ] blur: `15.0` ✓
- [ ] Visual consistency with Light mode ✓

### surfaceTertiary - All Modes
- [ ] Derived from tertiary palette ✓
- [ ] Accent styling implemented ✓
- [ ] Consistent with Glass aesthetic ✓

---

## Brutal Theme Implementation

File: `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart`

### surfaceSecondary
- [ ] backgroundColor: `scheme.surfaceContainerHigh` (grey solid/halftone) ✓
- [ ] borderColor: `scheme.onSurface` (thick black border) ✓
- [ ] borderWidth: `2.0` (vs 3.0 for Highlight) ✓
- [ ] borderRadius: `0` (no radius for mechanical aesthetic) ✓
- [ ] Visual intent: Mechanical "pressed" state ✓

### surfaceTertiary
- [ ] Grey with accent border ✓
- [ ] Maintains mechanical aesthetic ✓

---

## Flat Theme Implementation

File: `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`

### surfaceSecondary
- [ ] backgroundColor: `scheme.secondaryContainer` (Material 3) ✓
- [ ] contentColor: `scheme.onSecondaryContainer` ✓
- [ ] Visual intent: Material 3 Tonal Container ✓

### surfaceTertiary
- [ ] Uses Material 3 tertiary palette ✓
- [ ] Accent styling with Material 3 colors ✓

---

## Neumorphic Theme Implementation

File: `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart`

### surfaceSecondary
- [ ] backgroundColor: `scheme.surface` ✓
- [ ] Shallow convex shadows ✓
- [ ] blur: `5.0` (vs higher for Elevated) ✓
- [ ] offset: `2.0` (subtle lift) ✓
- [ ] Visual intent: Subtle tactile lift ✓

### surfaceTertiary
- [ ] Tactile accent variant ✓
- [ ] Consistent Neumorphic physics ✓

---

## Pixel Theme Implementation

File: `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`

### surfaceSecondary
- [ ] 2px grid pattern on `surfaceVariant` ✓
- [ ] Maintains pixel aesthetic ✓
- [ ] Visually distinct from Base ✓

### surfaceTertiary
- [ ] Pixelated accent styling ✓
- [ ] Consistent with Pixel theme aesthetic ✓

---

## Validation Across All Themes

- [ ] Each theme provides valid `surfaceSecondary` definition ✓
- [ ] Each theme provides valid `surfaceTertiary` definition ✓
- [ ] All files compile without errors ✓
- [ ] Visual definitions match research.md specifications ✓
- [ ] Physics (blur, borders, shadows) consistent across themes ✓

---

## Code Generation Requirements

- [ ] All files use `@TailorMixin()` if extending `AppDesignTheme` ✓
- [ ] Ready for `dart run build_runner build` (T008) ✓

---

## Cross-Theme Consistency

### Physics Consistency
- [ ] Press scale: `0.97` uniform across themes ✓
- [ ] Animation duration: `theme.animation.duration` ✓
- [ ] Blur values: Glass 15.0, Neumorphic 5.0 ✓
- [ ] Border widths: Brutal 2.0 (Tonal) vs 3.0 (Highlight) ✓

### Color Token Consistency
- [ ] secondaryContainer tokens: Light 0xFFDCE3F0, Dark 0xFF314561 ✓
- [ ] onSecondaryContainer tokens: Light 0xFF1E2A3A, Dark 0xFFE0E8F8 ✓
- [ ] Material 3 palette usage in Flat theme ✓

### Naming Consistency
- [ ] All surfaces named `surfaceSecondary` (not `tonalSurface`, etc.) ✓
- [ ] All uses of `surfaceTertiary` consistent ✓

---

## Sign-Off

**Implementation Owner**: [Name]
**Date Started**:
**Date Completed**:
**Issues Found**:
**Resolution Notes**:

