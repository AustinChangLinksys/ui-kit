import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/app_bar_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/dialog_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/divider_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/loader_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/app_menu_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/navigation_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/network_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toast_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toggle_style.dart';
import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/effects/global_effects_type.dart';
import 'package:ui_kit_library/src/foundation/icons/app_icon_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/bottom_sheet_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/side_sheet_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/tabs_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/stepper_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/breadcrumb_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/expansion_panel_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/carousel_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/chip_group_style.dart';
import 'specs/surface_style.dart';

part 'app_design_theme.tailor.dart';

@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme>
    with _$AppDesignThemeTailorMixin {
  @override
  final ToggleStyle toggleStyle;

  @override
  final SkeletonStyle skeletonStyle;

  @override
  final InputStyle inputStyle;

  @override
  final LoaderStyle loaderStyle;

  @override
  final ToastStyle toastStyle;

  @override
  final DividerStyle dividerStyle;

  @override
  final NetworkInputStyle networkInputStyle;

  @override
  final SurfaceStyle surfaceBase;
  @override
  final SurfaceStyle surfaceElevated;
  @override
  final SurfaceStyle surfaceHighlight;
  @override
  final SurfaceStyle surfaceSecondary;
  @override
  final SurfaceStyle surfaceTertiary;

  @override
  final TypographySpec typography;
  @override
  final AnimationSpec animation;
  @override
  final double spacingFactor;
  @override
  final LayoutSpec layoutSpec;

  @override
  final double buttonHeight;

  @override
  final NavigationStyle navigationStyle;

  @override
  final AppBarStyle appBarStyle;

  @override
  final AppMenuStyle menuStyle;

  @override
  final DialogStyle dialogStyle;

  @override
  final AppMotion motion;

  @override
  final GlobalEffectsType visualEffects;

  @override
  final AppIconStyle iconStyle;

  @override
  final BottomSheetStyle bottomSheetStyle;

  @override
  final SideSheetStyle sideSheetStyle;

  @override
  final TabsStyle tabsStyle;

  @override
  final StepperStyle stepperStyle;

  @override
  final BreadcrumbStyle breadcrumbStyle;

  @override
  final ExpansionPanelStyle expansionPanelStyle;

  @override
  final CarouselStyle carouselStyle;

  @override
  final ChipGroupStyle chipGroupStyle;

  const AppDesignTheme({
    required this.surfaceBase,
    required this.surfaceElevated,
    required this.surfaceHighlight,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.toggleStyle,
    required this.skeletonStyle,
    required this.inputStyle,
    required this.loaderStyle,
    required this.toastStyle,
    required this.dividerStyle,
    required this.networkInputStyle,
    required this.typography,
    required this.animation,
    required this.spacingFactor,
    required this.buttonHeight,
    required this.navigationStyle,
    required this.layoutSpec,
    required this.appBarStyle,
    required this.menuStyle,
    required this.dialogStyle,
    required this.motion,
    required this.visualEffects,
    required this.iconStyle,
    required this.bottomSheetStyle,
    required this.sideSheetStyle,
    required this.tabsStyle,
    required this.stepperStyle,
    required this.breadcrumbStyle,
    required this.expansionPanelStyle,
    required this.carouselStyle,
    required this.chipGroupStyle,
  });
}
