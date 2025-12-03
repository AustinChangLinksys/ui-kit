# AppSurface Current Behavior Analysis (T003)

**Date**: 2025-12-03
**File**: `lib/src/atoms/surfaces/app_surface.dart` (113 lines)
**Purpose**: Document current implementation before modifications for T009

---

## Current Implementation Summary

### Class Structure
- **Type**: `StatelessWidget` (not stateful in current implementation)
- **Constructor Parameters**:
  - `required Widget child`
  - `SurfaceVariant variant = SurfaceVariant.base` (default)
  - `VoidCallback? onTap`
  - `double? width`, `double? height`
  - `EdgeInsetsGeometry? padding`
  - `bool interactive = false`
  - `SurfaceStyle? style` (explicit style override)
  - `BoxShape shape = BoxShape.rectangle`

### Current SurfaceVariant Enum
```dart
enum SurfaceVariant { base, elevated, highlight }
```
**Current Values**: 3 variants
- `base`: Low emphasis
- `elevated`: High emphasis
- `highlight`: Maximum emphasis

**Missing Values** (To be added in T006):
- `tonal`: Medium emphasis (maps to `surfaceSecondary`)
- `accent`: Decorative emphasis (maps to `surfaceTertiary`)

---

## Current Build Implementation

### Theme Resolution (Lines 33-45)
1. Gets theme from context via `Theme.of(context).extension<AppDesignTheme>()`
2. Falls back to plain `Container` if theme is null
3. Resolves style via `_resolveStyle(theme, variant)`
4. Uses explicit `style` parameter if provided (highest priority)

### Animation & Rendering (Lines 49-76)
1. **AnimatedContainer**: Uses `theme.animation.duration` and `curve`
   - Animates when theme/style changes
2. **Decoration** applied:
   - `backgroundColor` from style
   - `customBorder` or auto-generated `Border.all()` from style
   - `borderRadius` based on style
   - `boxShadow` from style
3. **Text Styling**: DefaultTextStyle with `contentColor` from style
4. **Blur Support** (Lines 78-89):
   - If `blurStrength > 0`: Wraps in `ClipRRect` + `BackdropFilter`
   - Used for Glass theme aesthetic

### Gesture Handling (Lines 91-97)
1. Only wraps in `GestureDetector` if `onTap` or `interactive` is true
2. **Current limitation**: No press animation or press-state tracking
   - This is where T009 will add `AnimatedScale` for press feedback

---

## Style Resolution Method

### `_resolveStyle()` Implementation (Lines 102-111)
```dart
SurfaceStyle _resolveStyle(AppDesignTheme theme, SurfaceVariant variant) {
  switch (variant) {
    case SurfaceVariant.base:
      return theme.surfaceBase;
    case SurfaceVariant.elevated:
      return theme.surfaceElevated;
    case SurfaceVariant.highlight:
      return theme.surfaceHighlight;
  }
}
```

**Current Behavior**:
- Maps enum variants to theme properties
- **No handling for `tonal` or `accent`** (will be added in T006)
- Always returns a `SurfaceStyle` object
- No null checking (enum exhaustiveness ensures all cases covered)

---

## Current Usage Pattern

### Existing Components Using AppSurface
From codebase search:
- AppButton (passes variant)
- AppCard (uses default variant=base)
- AppTag (uses default variant=base)
- AppNavigationBar items (uses variant)

### Example Usage (Current)
```dart
AppSurface(
  variant: SurfaceVariant.highlight,
  onTap: () => onPressed?.call(),
  interactive: true,
  child: Center(child: AppText(text: label)),
)
```

---

## Planned Modifications (T009)

The current StatelessWidget will be converted to StatefulWidget with:

### New Features to Add
1. **State Management**: Convert to `StatefulWidget` with `_AppSurfaceState`
   - Add `AnimationController` for smooth press animations
   - Track `_isPressed` state
   - Manage animation lifecycle

2. **Interaction Physics**: Add press feedback
   - AnimatedScale from 1.0 → 0.97 on press
   - Smooth animation using `theme.animation.duration`
   - Reset to 1.0 on tap up/cancel

3. **Enum Expansion**: Extend `SurfaceVariant`
   - Add `tonal` → maps to `surfaceSecondary`
   - Add `accent` → maps to `surfaceTertiary`

4. **Style Resolution Enhancement**: Update `_resolveStyle()`
   - Handle new enum cases
   - Maintain exhaustiveness checking

### Breaking Changes
- None expected - enum expansion is additive
- Existing code using `SurfaceVariant.base/elevated/highlight` continues to work

### Backward Compatibility
✅ Fully backward compatible
- Default `variant = SurfaceVariant.base` maintained
- Existing constructor parameters unchanged
- New `AnimationController` is internal state only

---

## SurfaceVariant Enum Usage Across Codebase

**Current Usage**:
```
SurfaceVariant.base      → Used as default
SurfaceVariant.elevated  → Used for modals, dialogs
SurfaceVariant.highlight → Used for primary buttons, CTAs
```

**After T006 Expansion**:
```
SurfaceVariant.base      → Low emphasis (existing)
SurfaceVariant.elevated  → High emphasis floating (existing)
SurfaceVariant.highlight → Maximum emphasis actions (existing)
SurfaceVariant.tonal     → NEW: Medium emphasis selected states
SurfaceVariant.accent    → NEW: Decorative/special states
```

---

## Integration Points

### Theme Integration
- Already uses `Theme.of(context).extension<AppDesignTheme>()`
- Expects theme properties: `surfaceBase`, `surfaceElevated`, `surfaceHighlight`
- **After T007**: Will also expect `surfaceSecondary`, `surfaceTertiary`

### Animation Integration
- Uses `theme.animation.duration` and `theme.animation.curve`
- **T009 will add**: `AnimationController` scoped to AppSurface state

### Component Integration
- AppButton, AppNavigationBar, AppTag all inherit AppSurface styling
- No components currently use `variant` parameter (will be added in T017-T022)

---

## Key Insights for T009 Implementation

1. **Press Animation Framework Exists**: AnimatedContainer already animates style changes
   - Adding AnimatedScale should use same duration/curve for consistency

2. **Blur Already Supported**: BackdropFilter logic is in place
   - Glass theme already uses blur via SurfaceStyle.blurStrength
   - Press animation should work seamlessly with blur

3. **GestureDetector Already Present**: Interactive parameter controls gesture wrapping
   - T009 can enhance tap behavior without restructuring

4. **Theme Extension Pattern Established**: No new theme integration needed
   - Just add properties to theme (T007)
   - _resolveStyle() handles mapping (T006)

5. **No Performance Concerns**: Current implementation is straightforward
   - StatefulWidget conversion is local to AppSurface
   - Press animation uses standard Flutter AnimatedScale
   - No complex calculations or external dependencies

---

## Files Affected by T009

**Modified**:
- `lib/src/atoms/surfaces/app_surface.dart` (convert to StatefulWidget, add _AppSurfaceState, add animation)

**Not Modified** (referenced only):
- `lib/src/foundation/theme/design_system/app_design_theme.dart` (modified in T007)
- `lib/src/atoms/surfaces/*` (other surface files, if any)
- All components using AppSurface (work as-is with new press animation)

---

## Pre-T009 Validation Checklist

- [x] Current enum has 3 values (base, elevated, highlight)
- [x] _resolveStyle() handles all enum cases
- [x] Theme integration via extension present
- [x] AnimatedContainer already handles style animation
- [x] BackdropFilter handles blur
- [x] GestureDetector conditional present
- [x] No press state tracking currently implemented
- [x] StatelessWidget - ready for StatefulWidget conversion
- [x] No external dependencies blocking conversion

---

## Conclusion

AppSurface is well-designed and ready for T009 enhancements. The structure supports:
- ✅ Enum expansion (new variants won't break existing code)
- ✅ StatefulWidget conversion (animation controller will be internal state)
- ✅ Press animation (uses existing animation infrastructure)
- ✅ New theme properties (extension pattern established)

**Confidence Level**: HIGH - Implementation path is clear and low-risk.

