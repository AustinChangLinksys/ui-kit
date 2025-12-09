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
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/tabs_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/stepper_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/breadcrumb_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/expansion_panel_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/carousel_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/chip_group_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/topology_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/table_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/slide_action_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/expandable_fab_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/gauge_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/sheet_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/styled_text_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/text_button_style.dart';
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

  @override
  final TopologySpec topologySpec;

  @override
  final TableStyle tableStyle;

  @override
  final SlideActionStyle slideActionStyle;

  @override
  final ExpandableFabStyle expandableFabStyle;

  @override
  final GaugeStyle gaugeStyle;

  @override
  final RangeInputStyle rangeInputStyle;

  @override
  final PinInputStyle pinInputStyle;

  @override
  final PasswordInputStyle passwordInputStyle;

  /// Unified sheet style for both bottom sheets and side sheets.
  ///
  /// Composes [OverlaySpec] for overlay appearance and animation.
  /// Use this instead of [bottomSheetStyle] and [sideSheetStyle] for new code.
  @override
  final SheetStyle sheetStyle;

  /// Style specification for AppStyledText component.
  ///
  /// Contains theme-driven styling for text variants and link interactions.
  /// Follows Constitution 4.6 by composing AnimationSpec and StateColorSpec.
  @override
  final StyledTextStyle styledTextStyle;

  /// Style specification for AppTextButton component.
  ///
  /// Contains theme-driven styling for text buttons including surface styles,
  /// typography, and interaction specifications for different button states.
  /// Follows Constitution 4.6 by composing SurfaceStyle and InteractionSpec.
  @override
  final TextButtonStyle textButtonStyle;

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
    required this.tabsStyle,
    required this.stepperStyle,
    required this.breadcrumbStyle,
    required this.expansionPanelStyle,
    required this.carouselStyle,
    required this.chipGroupStyle,
    required this.topologySpec,
    required this.tableStyle,
    required this.slideActionStyle,
    required this.expandableFabStyle,
    required this.gaugeStyle,
    required this.rangeInputStyle,
    required this.pinInputStyle,
    required this.passwordInputStyle,
    required this.sheetStyle,
    required this.styledTextStyle,
    required this.textButtonStyle,
  });

  /// Helper method to easily access the theme from the context.
  /// Throws a detailed error if the theme is not found in the context.
  static AppDesignTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    if (theme == null) {
      throw FlutterError(
        'AppDesignTheme operation requested with a context that does not include an AppDesignTheme.\n'
        'The context used was: $context. \n'
        'Make sure that your MaterialApp theme data includes the AppDesignTheme extension.',
      );
    }
    return theme;
  }
}
